Spree::Api::ApiHelpers.module_eval do
  mattr_reader :design_attributes, :template_attributes, :design_configuration_attributes, :design_option_attributes

  class_variable_set(:@@design_attributes, [:id, :size, :medium, :template_id, :markup, :images, :user_id])
  class_variable_set(:@@template_attributes, [:id, :name, :medium, :popularity])
  class_variable_set(:@@design_configuration_attributes, [:id, :size, :name, :meta])
  class_variable_set(:@@design_option_attributes, [:id, :medium, :name, :meta, :simple_designer, :simple_canvas_height, :simple_canvas_width, :number_of_lines])
end
