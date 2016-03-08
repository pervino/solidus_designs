module Spree
  module Api
    class DesignsController < Spree::Api::BaseController

      before_action :find_design, only: [:update, :destroy, :show]
      before_action :authorize_user, only: [:create, :update]

      def create
        authorize! :create, Design

        @design = Design.new(permitted_params)

        if params[:design][:is_template]
          set_as_template
        else
          set_user
        end

        if @design.save
          # Clear the designs template as the selected template
          (session[:current_template] ||= {})[@design.design_type.to_sym] = nil

          respond_with(@design, status: 201, default_template: :show)
        else
          invalid_resource!(@design)
        end
      end

      def update
        authorize! :update, Design

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
        authorize! :destroy, Design

        if @design.destroy
          render :text => '{}', :status => :ok
        else
          invalid_resource!(@design)
        end
      end

      def index
        authorize! :admin, current_api_user
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

        @designs = Spree::Design.ransack(params[:q]).result
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

      def set_user
        if params[:design][:user_id].present? && (user = Spree::User.find(params[:design][:user_id])).present?
          @design.user = user
        elsif current_api_user && current_api_user.persisted?
          @design.user = current_api_user
        else
          @design.guest_token = cookies.signed[:guest_token]
        end
      end

      def authorize_user
        params[:design].delete :user_id unless can? :admin, current_api_user
      end

      def permitted_params
        params.require(:design).permit :medium, :size, :markup, :name, :template_id, :risky, *(Spree::ItemDesign::Config.images.map { |s| s.to_sym })
      end

    end
  end
end