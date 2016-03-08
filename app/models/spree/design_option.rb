module Spree
  class DesignOption < Spree::Base
    include Spree::Customization::Option

    belongs_to :design_configuration
    has_one :product, through: :design_configuration
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"

    validates :medium, presence: true


    # Creates necessary tax adjustments for the order.
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

    def adjustment_label(amount = nil)
      "Personalization"
    end
  end
end