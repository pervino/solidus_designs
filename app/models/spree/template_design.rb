module Spree
  class TemplateDesign < Spree::Base
    belongs_to :template, touch: true
    belongs_to :design, touch: true

    validates :design, uniqueness: true
    validate :template_designs_unique_in_size

    self.whitelisted_ransackable_attributes = ['template_id']
    self.whitelisted_ransackable_associations = ['design', 'template']

    private

    def template_designs_unique_in_size
      if template.designs.map(&:size).uniq.length != template.designs.length
        errors.add(:template, "designs must have unique sizes")
      end
    end
  end
end