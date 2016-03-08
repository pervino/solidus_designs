cache [root_object]
attributes *template_attributes

node :images do |joined_template|
  design = Spree::Design.find(joined_template.design_id)

  {
    small: design.rendering.url(:small),
    medium: design.rendering.url(:medium)
  }
end