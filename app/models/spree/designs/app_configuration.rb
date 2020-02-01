module Spree
  class Designs::AppConfiguration < Preferences::Configuration
    preference :tags, :array, default: [:holidays, :occasions, :recipients, :colors]

    preference :sizes, :array, default: [:bordeaux, :square, :teardrop, :woodbox_single, :woodbox_double, :woodbox_triple, :woodbox_photo_single, :woodbox_photo_double, :woodbox_photo_triple, :veuve, :custom_drink]

    preference :mediums, :array, default: [:label, :engraving]
  end
end