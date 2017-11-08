json.cache! [design] do
  json.extract! design, :id, :size, :medium, :template_id, :markup, :images, :user_id
end

json.rendering do |json, design|
  json.small design.rendering.url(:small)
  json.medium design.rendering.url(:medium)
  json.large design.rendering.url(:large)
  json.original design.rendering.url(:original)
end
