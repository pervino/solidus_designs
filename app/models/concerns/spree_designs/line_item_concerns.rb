module SpreeDesigns::LineItemConcerns
  extend ActiveSupport::Concern

  def available_design_configurations
    product.design_configurations
  end
end
