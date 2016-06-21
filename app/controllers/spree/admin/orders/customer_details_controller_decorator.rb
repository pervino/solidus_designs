Spree::Admin::Orders::CustomerDetailsController.class_eval do
  after_action :associate_designs, only: [:update]

  private

  def associate_designs
    return unless @order.user_id?

    @order.associate_designs
  end
end