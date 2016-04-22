Rails.application.config.to_prepare do
  Spree::Api::LineItemsController.line_item_options << {customizations_attributes: [:source_id, :source_type, :configuration_id, :configuration_type, :option_type, :option_id]}
end