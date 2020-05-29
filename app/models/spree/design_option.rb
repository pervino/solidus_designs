module Spree
  class DesignOption < Spree::Base
    acts_as_paranoid

    # Need to deal with adjustments before calculator is destroyed.
    before_destroy :deals_with_adjustments_for_deleted_source

    include Spree::CalculatedAdjustments
    include Spree::AdjustmentSource

    has_many :adjustments, as: :source
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::DesignOptionImage"
    belongs_to :design_configuration, -> { with_deleted }, touch: true
    belongs_to :spree_designs, inverse_of: :designs
    has_one :product, through: :design_configuration

    scope :active, -> { where(active: true) }
    scope :ordered, -> { order(position: :asc) }

    acts_as_taggable
    acts_as_list scope: [:design_configuration_id]

    store_accessor :meta, :description

    before_validation :ensure_action_has_calculator
    validates :medium, presence: true


    def adjust(item)
      amount = compute_amount(item)
      return if amount == 0

      item.adjustments.create!(
          source: self,
          amount: amount,
          order_id: item.order_id,
          label: adjustment_label(amount)
      )
    end


    # This method is used by Adjustment#update to recalculate the cost.
    def compute_amount(item)
      calculator.compute(item)
    end

    private

    def ensure_action_has_calculator
      return if calculator
      self.calculator = Calculator::FlatRatePerItem.new
    end

    def adjustment_label(amount = nil)
      label || "Personalization - #{medium}"
    end
  end
end
