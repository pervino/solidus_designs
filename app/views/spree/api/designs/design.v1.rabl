cache [root_object]
attributes *design_attributes

node :rendering do |design|
  {
    small: design.rendering.url(:small),
    medium: design.rendering.url(:medium),
    original: design.rendering.url(:original)
  }
end