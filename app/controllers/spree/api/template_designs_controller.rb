module Spree
  module Api
    class TemplateDesignsController < Spree::Api::BaseController
      before_action :find_template_design, only: [:update, :show]
      skip_before_action :authenticate_user

      def index
        # binding.pry
        params[:q] ||= {}
        params[:q][:s] ||= ["template_popularity desc"]
        params[:q][:template_display_eq] ||= true

        medium = params[:template_medium_eq]
        display = params[:template_display_eq]
        size = params[:design_size_eq]

        if params[:tagged_with]
          if params[:tagged_with] != 'false'
            if params[:tagged_with] != 'true'
              tag = ActsAsTaggableOn::Tag.find_by(name: params[:tagged_with])
            else
              tag = ActsAsTaggableOn::Tag.new(id: 0)
            end
          else
            tag = ActsAsTaggableOn::Tag.new(id: 0)
          end

          templates = Spree::Template.tagged_with(params[:tagged_with], :on => :tags, any: true)
          params[:q][:template_id_in] = templates.pluck(:id)

          # Otherwise all templates will be found when no tagged templates were found
          if templates.any?
            params[:q][:template_id_in] = templates.pluck(:id)
          else
            params[:q][:template_id_in] = [-1]
          end
        end

        if params[:tagged_with]
          if params[:tagged_with].is_a?(Array) && params[:tagged_with].length > 1
            @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
          else
            @template_designs = Spree::TemplateDesign.tagged_and_pinned(tag, medium, display, size)
          end
        else
          @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
        end
        # @template_designs = @template_designs.where(size: params[:design_size_eq])
        # @template_designs = @template_designs.where(medium: params[:template_medium_eq])
        # binding.pry

        # @template_designs.each do |template, index|
        #   if Spree::Design.find_by(template.design_id).size != sizeSimple
        #     @template_designs.delete_at(index)
        #   end
        # end
        # @template_designs.each do |template, index|
        #   if Spree::Design.find_by(template.design_id).medium != mediumSimple
        #     @template_designs.delete_at(index)
        #   end
        # end
        ## need to cull this down by removing designs that are the size and medium
        # @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
        @template_designs = @template_designs.page(params[:page]).per(params[:per_page])
      end

      def list

      end

      def create
        authorize! :create, TemplateDesign

        @template_design = TemplateDesign.new(permitted_params)

        if @template_design.save
          respond_with(@template_design, status: 201, default_template: :show)
        else
          invalid_resource!(@template_design)
        end
      end

      def update
        authorize! :update, @template_design

        if @template_design.update_attributes(permitted_params)
          respond_with(@template_design, default_template: :show)
        else
          invalid_resource!(@template_design)
        end
      end

      def show
      end

      private

      def find_template_design
        @template_design = TemplateDesign.find(params[:id])
      end

      def permitted_params
        params.require(:template_design).permit(permitted_attributes)
      end

      def permitted_attributes
        can?(:admin, Spree::TemplateDesign) ? [:template_id, :design_id] : []
      end
    end
  end
end
