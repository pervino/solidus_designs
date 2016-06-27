module Spree
  module Designs
    class ProductDuplicator

      def initialize(destination_product, source_product)
        @source = source_product
        @destination = destination_product
      end

      def duplicate
        @destination.design_configurations = @source.design_configurations.map { |design_configuration| duplicate_design_configuration design_configuration }
        @destination.save!
        @destination
      end

      protected

      def duplicate_design_configuration(design_configuration)
        design_configuration.dup.tap do |new_design_configuration|
          new_design_configuration.created_at = nil
          new_design_configuration.deleted_at = nil
          new_design_configuration.updated_at = nil
          new_design_configuration.design_options = design_configuration.design_options.map { |design_option| duplicate_design_option design_option }
        end
      end

      def duplicate_design_option(design_option)
        new_design_option = design_option.dup
        new_design_option.deleted_at = nil
        new_design_option.images = design_option.images.map { |image| duplicate_image image }
        new_design_option
      end

      def duplicate_image(image)
        new_image = image.dup
        new_image.assign_attributes(attachment: image.attachment.clone)
        new_image
      end
    end
  end
end

