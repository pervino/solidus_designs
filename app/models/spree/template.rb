module Spree
  class Template < Spree::Base
    acts_as_paranoid
    acts_as_taggable

    has_many :template_designs
    has_many :designs, through: :template_designs

    scope :display, -> { where(display: true) }

    self.whitelisted_ransackable_attributes = ['medium', 'display', 'popularity']
  end
end