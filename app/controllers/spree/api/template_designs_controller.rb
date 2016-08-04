module Spree
  module Api
    class TemplateDesignsController < Spree::Api::BaseController
      before_action :find_template_design, only: [:update]

      def index
        params[:q] ||= {}
        params[:q][:s] ||= ["template_popularity desc"]

        if params[:tagged_with]
          templates = Spree::Template.tagged_with(params[:tagged_with], any: true)
          params[:q][:template_id_in] = templates.pluck(:id)

          # Otherwise all templates will be found when no tagged templates were found
          if templates.any?
            params[:q][:template_id_in] = templates.pluck(:id)
          else
            params[:q][:template_id_in] = [-1]
          end
        end

        @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
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