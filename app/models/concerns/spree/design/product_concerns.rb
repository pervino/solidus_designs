module Spree
  module Design::ProductConcerns
    extend ActiveSupport::Concern

    included do
      prepend(InstanceMethods)

      has_many :design_configurations, dependent: :destroy
    end

    module InstanceMethods
      def duplicate_extra(original)
        self.design_configurations = original.design_configurations
      end

      def can_design?(designType = nil)
        true
      end

      def label_image
        images.first
      end

      def engraving_image
        images.last
      end
    end
  end
end
