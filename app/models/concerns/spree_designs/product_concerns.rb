module SpreeDesigns::ProductConcerns
  extend ActiveSupport::Concern

  included do
    has_many :design_configurations, dependent: :destroy

    prepend(InstanceMethods)
  end

  module InstanceMethods
    def duplicate_extra(product)
      Spree::Designs::ProductDuplicator.new(product, self).duplicate
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
