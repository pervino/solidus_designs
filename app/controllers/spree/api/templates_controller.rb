module Spree
  module Api
    class TemplatesController < Spree::Api::BaseController
      before_action :cors_preflight_check
      after_action :cors_set_access_control_headers
      skip_before_action :authenticate_user

      def index
        params[:q] ||= {}
        params[:q][:display_eq] ||= true

        size = params[:q].delete :size_eq
        tagged_with = params[:q].delete :tagged_with

        @templates = Spree::Template.ransack(params[:q]).result
          .joins(:designs)
          .where("#{Spree::Design.table_name}.size = ?", size)
          .select('spree_templates.*, spree_designs.id as design_id')
        @templates = @templates.tagged_with(tagged_with, :on => :tags, any: true) if tagged_with
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

      def cors_set_access_control_headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email'
        response.headers['Access-Control-Max-Age'] = "1728000"
      end
         
      def cors_preflight_check
        if request.method == 'OPTIONS'
          request.headers['Access-Control-Allow-Origin'] = '*'
          request.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
          request.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Spree-Token, X-Prototype-Version, Token, Auth-Token, Email'
          request.headers['Access-Control-Max-Age'] = '1728000'  
          render :text => '', :content_type => 'application/json'
        end
      end

    end
  end
end