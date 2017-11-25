module Spree
  module Designs
    class ProductDuplicator

      attr_reader :original_product, :new_product

      def initialize(original_product, new_product)
        @original_product = original_product
        @new_product = new_product
      end

      def duplicate
        binding.pry
        new_product.design_configurations = original_product.design_configurations.map { |design_configuration| duplicate_design_configuration(design_configuration) }
        new_product
      end

      protected

      def duplicate_design_configuration(design_configuration)
        design_configuration.dup.tap do |new_design_configuration|
          new_design_configuration.created_at = nil
          new_design_configuration.deleted_at = nil
          new_design_configuration.updated_at = nil
          new_design_configuration.design_options = design_configuration.design_options.map { |design_option| duplicate_design_option(design_option) }
        end
      end

      def duplicate_design_option(design_option)
        new_design_option = design_option.dup
        new_design_option.deleted_at = nil
        new_design_option.images = design_option.images.map { |image| duplicate_image image }
        new_design_option.calculator = design_option.calculator.dup
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
