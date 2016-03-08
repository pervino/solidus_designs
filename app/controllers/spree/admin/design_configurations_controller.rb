module Spree
  module Admin
    class DesignConfigurationsController < ResourceController
      belongs_to 'spree/product', find_by: :slug

      before_action :load_data, only: [:edit, :update]

      private

      def load_data
        @design_options = @design_configuration.design_options
      end
    end
  end
end