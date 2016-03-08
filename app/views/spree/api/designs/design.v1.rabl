cache [root_object]
attributes *design_attributes

node :images do |design|
  {
    small: design.rendering.url(:small),
    medium: design.rendering.url(:medium)
  }
end