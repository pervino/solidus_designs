module Spree
  class Template < Spree::Base
    acts_as_paranoid
    acts_as_taggable
    acts_as_taggable_on *(Spree::Designs::Config.tags)

    has_many :template_designs
    has_many :designs, through: :template_designs

    self.whitelisted_ransackable_attributes = ['medium', 'display', 'popularity']
  end
end