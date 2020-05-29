Spree::PermittedAttributes.module_eval do
  mattr_accessor :design_attributes, :template_attributes, :template_design_attributes

  class_variable_set(:@@design_attributes, [
      :user_id, :medium, :name, :size, :markup, :render_url, :source_id, :template_id, :spree_design_options_id
  ])

  class_variable_set(:@@template_attributes, [
      :name, :medium, :display, :tag_list, :popularity
  ])
end