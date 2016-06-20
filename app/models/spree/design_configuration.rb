module Spree
  class DesignConfiguration < Spree::Base
    include Spree::Customization::Configurable

    belongs_to :product
    has_many :design_options, dependent: :destroy

    validates :name, presence: true
    validates :size, presence: true
  end
end