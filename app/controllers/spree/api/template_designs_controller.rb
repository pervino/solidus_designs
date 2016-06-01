module Spree
  module Api
    class TemplateDesignsController < Spree::Api::BaseController

      def index
        params[:q] ||= {}
        params[:q][:s] ||= ["template_popularity desc"]

        if params[:tagged_with]
          templates = Spree::Template.tagged_with(params[:tagged_with], any: true)
          params[:q][:template_id_in] = templates.pluck(:id)
        end

        @template_designs = Spree::TemplateDesign.includes(:template, :design).ransack(params[:q]).result
        @template_designs = @template_designs.page(params[:page]).per(params[:per_page])
      end
    end
  end
end