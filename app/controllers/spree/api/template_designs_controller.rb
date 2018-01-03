module Spree
  module Api
    class TemplateDesignsController < Spree::Api::BaseController
      before_action :find_template_design, only: [:update, :show]
      skip_before_action :authenticate_user

      def index
        params[:q] ||= {}
        params[:q][:s] ||= ["template_popularity desc"]
        params[:q][:template_display_eq] ||= true

        medium = params[:q][:template_medium_eq]
        display = params[:q][:template_display_eq]
        size = params[:q][:design_size_eq]

        if params[:q][:tagged_with]
          if params[:q][:tagged_with] != 'false'
            tag = ActsAsTaggableOn::Tag.find_by(name: params[:q][:tagged_with])
          else
            tag = ActsAsTaggableOn::Tag.new(id: 0)
          end   

          templates = Spree::Template.tagged_with(params[:q][:tagged_with], :on => :tags, any: true)   
          params[:q][:template_id_in] = templates.pluck(:id)
          
          # Otherwise all templates will be found when no tagged templates were found
          if templates.any?
            params[:q][:template_id_in] = templates.pluck(:id)
          else
            params[:q][:template_id_in] = [-1]
          end
        end

        if params[:q][:tagged_with].length > 1
          @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
        else
          @template_designs = Spree::TemplateDesign.tagged_and_pinned(tag, medium, display, size)
        end

        @template_designs = @template_designs.page(params[:page]).per(params[:per_page])
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