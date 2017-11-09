json.cache! [design] do |design|
  json.(design, :id, :size, :medium, :template_id, :markup, :images, :user_id)
  json.rendering do
    json.small design.rendering.url(:small)
    json.medium design.rendering.url(:medium)
    json.large design.rendering.url(:large)
    json.original design.rendering.url(:original)
  end
end

