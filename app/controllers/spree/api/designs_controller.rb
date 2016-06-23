module Spree
  module Api
    class DesignsController < Spree::Api::BaseController
      before_action :find_design, only: [:update, :destroy, :show]

      def create
        authorize! :create, Design

        @design = Design.new(permitted_params)

        if params[:design][:is_template]
          set_as_template
        else
          associate_user
        end

        if @design.save
          # Clear the designs template as the selected template
          (session[:current_template] ||= {})[@design.size.to_sym] = nil
          respond_with(@design, status: 201, default_template: :show)
        else
          invalid_resource!(@design)
        end
      end

      def update
        authorize! :update, @design

        if params[:force]
          @design.skip_line_item_touch = params[:force]
        end

        if @design.update_attributes(permitted_params)
          respond_with(@design, default_template: :show)
        else
          invalid_resource!(@design)
        end
      end

      def destroy
        authorize! :destroy, @designs
        @design.destroy
        respond_with(@designs, status: 204)
      end

      def index
        # authorize! :index, Design
        @designs = Design.unscoped.ransack(params[:q]).
            result.order('created_at DESC').
            page(params[:page]).
            per(params[:per_page] || Spree::Config[:orders_per_page])
        respond_with(@designs)
      end

      def mine
        params[:q] ||= {}

        if current_api_user && current_api_user.persisted?
          params[:q][:user_id_eq] = current_api_user.id
        else
          params[:q][:guest_token_eq] = cookies.signed[:guest_token]
        end

        @designs = Spree::Design.includes(:template).ransack(params[:q]).result
        @designs = @designs.page(params[:page]).per(params[:per_page])
        respond_with(@designs, default_template: 'index')
      end

      private

      def find_design
        @design = Design.unscoped.find(params[:id])
      end

      def set_as_template
        authorize! :admin, current_api_user
        @design.is_template = true
        @design.user_id = nil
      end

      def associate_user
        return if params[:design][:user_id]

        if current_api_user && current_api_user.persisted?
          @design.user = current_api_user
        else
          @design.guest_token = cookies.signed[:guest_token]
        end
      end

      def permitted_params
        attributes = can?(:admin, Spree::Design) ? admin_permitted_attributes : permitted_attributes
        params.require(:design).permit *attributes
      end

      def permitted_attributes
        Spree::PermittedAttributes.design_attributes
      end

      def admin_permitted_attributes
        permitted_attributes + [:name, :user_id]
      end
    end
  end
end