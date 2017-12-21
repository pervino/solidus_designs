module Spree
  class Template < Spree::Base
    acts_as_paranoid
    acts_as_taggable

    has_many :template_designs
    has_many :designs, through: :template_designs
    has_many :pins, foreign_key: :template_id

    scope :display, ->{ where(display: true) }
    scope :pinned_for, ->(tag) { includes(:pins).where('pins.tag_id = ?', tag.id).references(:pins) }
    scope :tagged_for, ->(tag) { includes(:taggings).where('taggings.tag_id = ?', tag.id).references(:taggings) }

    scope :tagged_and_pinned_for, ->(tag) { 
      left_outer_joins(:tags)
      .where(tags: { name: tag.name })
      .select(:id, :name, "CASE WHEN EXISTS
        (SELECT pins.id FROM pins WHERE pins.tag_id = tags.id
        AND pins.template_id = spree_templates.id)
        THEN true
        ELSE false
        END AS pinned")
      .order("pinned DESC, spree_templates.popularity DESC")
    }

    self.whitelisted_ransackable_attributes = ['medium', 'display', 'popularity']

    def pinned?(tag_id)
      self.pins.map {|p| p.tag_id}.include? tag_id
    end

    def self.sort_by_pins(tag_id)
      Spree::Template.all.sort_by {|t| t.pinned?(tag_id) ? 0 : 1}
    end
  end
end