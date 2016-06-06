cache [root_object]
attributes :id, :size, :medium, :template_id, :markup, :images, :user_id

node :rendering do |design|
  {
    small: design.rendering.url(:small),
    medium: design.rendering.url(:medium),
    original: design.rendering.url(:original)
  }
end