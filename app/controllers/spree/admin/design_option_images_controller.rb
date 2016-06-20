module Spree
  module Admin
    class DesignOptionImagesController < ResourceController
      before_action :load_data

      create.before :set_viewable
      update.before :set_viewable

      private

      def location_after_destroy
        admin_design_option_images_path(@design_option)
      end

      def location_after_save
        admin_design_option_images_path(@design_option)
      end

      def load_data
        @design_option = DesignOption.find(params[:design_option_id])
        @product = @design_option.product
      end

      def set_viewable
        @design_option_image.viewable_type = 'Spree::DesignOption'
        @design_option_image.viewable_id = @design_option.id
      end
    end
  end
end