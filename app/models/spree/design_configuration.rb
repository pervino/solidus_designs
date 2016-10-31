module Spree
  class DesignConfiguration < Spree::Base
    include Spree::Customization::Configurable

    acts_as_paranoid

    store_accessor :meta, :description, :dimensions

    belongs_to :product, touch: true
    has_many :design_options, -> { order(position: :asc) }, dependent: :destroy

    validates :name, presence: true
    validates :size, presence: true
  end
end