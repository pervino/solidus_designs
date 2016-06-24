module Spree
  module Admin
    class DesignOptionsController < ResourceController
      belongs_to 'spree/design_configuration'

      before_action :load_data

      private

      def location_after_save
        edit_admin_design_configuration_design_option_path(@design_configuration, @design_option)
      end

      def load_data
        @calculators = Rails.application.config.spree.calculators.design
        @design_configuration ||= DesignOption.find(params[:design_configuration_id])
        @product = @design_configuration.product
      end
    end
  end
end