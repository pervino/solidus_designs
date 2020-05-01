json.cache! [design] do
  json.(design, :id, :size, :medium, :template_id, :markup, :images, :user_id)
  json.rendering do
    if design.rendering
      json.small design.rendering.url(:small)
      json.medium design.rendering.url(:medium)
      json.large design.rendering.url(:large)
      json.original design.rendering.url(:original)
    else
      json.nil!
    end
  end
end

