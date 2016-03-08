module Spree
  class Template < Spree::Base
    acts_as_taggable_on *(Spree::Designs::Config.tags)

    has_many :designs

    self.whitelisted_ransackable_attributes = ['medium', 'display']
  end
end