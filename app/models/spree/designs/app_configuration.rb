module Spree
  class Designs::AppConfiguration < Preferences::Configuration
    preference :tags, :array, default: [:holidays, :occasions, :recipients, :colors]

    preference :sizes, :array, default: [:bordeaux, :square, :teardrop, :woodbox_single, :woodbox_double, :woodbox_triple, :woodbox_magnum, :woodbox_photo_single, :woodbox_photo_double, :woodbox_photo_triple, :woodbox_photo_magnum, :veuve, :custom_drink]

    preference :mediums, :array, default: [:label, :engraving, :simple_text, :simple_icon]
  end
end