module Spree
  class DesignConfiguration < Spree::Base
    include Spree::Customization::Configurable

    acts_as_paranoid

    store_accessor :meta, :description, :dimensions, :simple_designer, :simple_canvas_height, :simple_canvas_width, :number_of_lines

    belongs_to :product, touch: true
    has_many :design_options, -> { ordered }, dependent: :destroy

    validates :name, presence: true
    validates :size, presence: true
  end
end
