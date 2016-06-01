Spree::PermittedAttributes.module_eval do
  mattr_accessor :design_attributes, :template_attributes

  class_variable_set(:@@design_attributes, [
      :user_id, :medium, :name, :size, :markup, :render_url, :source_id, :template_id
  ])

  class_variable_set(:@@template_attributes, [
      :name, :medium, :display, :holiday_list, :occasion_list, :recipient_list, :color_list
  ])
end