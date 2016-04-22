require 'solidus_core'
require 'acts-as-taggable-on'

module Spree
  module Designs
    def self.config(&block)
      yield(Spree::Designs::Config)
    end
  end
end

require 'solidus_designs/engine'
