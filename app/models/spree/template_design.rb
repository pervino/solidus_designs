module Spree
  class TemplateDesign < Spree::Base
    belongs_to :template
    belongs_to :design

    validates :design, uniqueness: true
    validate :templates_designs_unique_in_size

    self.whitelisted_ransackable_attributes = ['template_id']
    self.whitelisted_ransackable_associations = ['design', 'template']

    private

    def templates_designs_unique_in_size
      if template.designs.map(&:size).uniq.length != template.designs.length
        errors.add(:template, "must have designs with unique sizes")
      end
    end
  end
end