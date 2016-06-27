module Spree
  module Design::ProductConcerns
    extend ActiveSupport::Concern

    included do
      has_many :design_configurations, dependent: :destroy

      prepend(InstanceMethods)
    end

    module InstanceMethods

      # Possibly call super here, though it may not be defined
      def duplicate_extra(original)
        Spree::Designs::ProductDuplicator.new(self, original).duplicate
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
