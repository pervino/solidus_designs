module Spree
  module Api
    class TemplatesController < Spree::Api::BaseController

      def index
        params[:q] ||= {}
        params[:q][:display_eq] ||= true

        size = params[:q].delete :size_eq
        tagged_with = params[:q].delete :tagged_with

        @templates = Spree::Template.ransack(params[:q]).result.joins(:designs).where("#{Spree::Design.table_name}.size = ?", size).select('spree_templates.*, spree_designs.id as design_id')
        @templates = @templates.tagged_with(tagged_with, any: true) if tagged_with
        @templates = @templates.page(params[:page]).per(params[:per_page])
      end

      def show
        @template = template
        respond_with(@template)
      end

      def tags
        params[:medium] ||= 'label,engraving'
        mediums = params[:medium].split(',')
        @tags = Spree::Template.display.where(medium: mediums).try(:tag_counts)
        render json: {tags: @tags}
      end

      private

      def template
        @template ||= Template.accessible_by(current_ability, :read).find(params[:id])
      end

    end
  end
end