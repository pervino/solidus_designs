module Spree
  class DesignConfiguration < Spree::Base
    include Spree::Customization::Configurable

    has_many :design_options, dependent: :destroy

    validates :size, presence: true
  end
end