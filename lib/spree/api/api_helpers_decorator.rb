Spree::Api::ApiHelpers.class_eval do
  mattr_reader :design_attributes, :template_attributes, :design_configuration_attributes, :design_option_attributes

  class_variable_set(:@@design_attributes, [:id, :type, :size, :medium, :markup, :images, :user_id])
  class_variable_set(:@@template_attributes, [:id, :name, :medium, :popularity])
  class_variable_set(:@@design_configuration_attributes, [:id, :size, :name, :meta])
  class_variable_set(:@@design_option_attributes, [:id, :medium, :name, :meta])
end