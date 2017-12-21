module Spree
  class TemplateDesign < Spree::Base
    belongs_to :template, touch: true
    belongs_to :design, touch: true

    validates :design, uniqueness: true
    validate :template_designs_unique_in_size

    scope :tagged_and_pinned, ->(tag, medium, display, size) {
      joins(:design,
            "INNER JOIN (
              SELECT DISTINCT spree_templates.*,
              CASE 
                WHEN EXISTS (
                  SELECT pins.id FROM pins
                  WHERE pins.tag_id = tags.id
                  AND pins.template_id = spree_templates.id
                )
                THEN true ELSE false END AS pinned
              FROM spree_templates, taggings, tags, pins
              WHERE spree_templates.id = taggings.taggable_id
                AND taggings.tag_id = tags.id
                AND tags.id = '#{tag.id}'
                AND taggings.context = 'tags'
                AND spree_templates.medium = '#{medium}'
                AND spree_templates.display = #{display}) AS spree_templates
              ON spree_template_designs.template_id = spree_templates.id"
            )
      .where("spree_designs.size = '#{size}'")
      .order('spree_templates.pinned DESC, spree_templates.popularity DESC')
    }

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