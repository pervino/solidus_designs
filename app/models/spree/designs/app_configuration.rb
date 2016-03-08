module Spree
  class Designs::AppConfiguration < Preferences::Configuration
    preference :tags, :array, default: [:holidays, :occasions, :recipients]

    preference :sizes, :array, default: [:bordeaux, :square, :teardrop]

    preference :mediums, :array, default: [:label, :engraving]
  end
end