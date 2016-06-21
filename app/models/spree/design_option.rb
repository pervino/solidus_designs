module Spree
  class DesignOption < Spree::Base
    include Spree::Customization::Source

    belongs_to :design_configuration
    belongs_to :preselected_design, class_name: "Spree::Design"
    has_one :product, through: :design_configuration
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::DesignOptionImage"

    before_validation :ensure_action_has_calculator
    validates :medium, presence: true


    def adjust(item)
      amount = compute_amount(item)
      return if amount == 0

      adjustments.create!({
                              adjustable: item,
                              amount: amount,
                              order_id: item.order_id,
                              label: adjustment_label(amount)
                          })
    end


    # This method is used by Adjustment#update to recalculate the cost.
    def compute_amount(item)
      calculator.compute(item)
    end

    def amount
      calculator.preferred_amount
    end

    private

    def ensure_action_has_calculator
      return if calculator
      self.calculator = Calculator::FlatRatePerItem.new
    end

    def adjustment_label(amount = nil)
      label || "Personalization"
    end
  end
end