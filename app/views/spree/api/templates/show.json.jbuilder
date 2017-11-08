json.(@template, *template_attributes)

json.designs(@template.designs) do |design|
  json.partial!("spree/api/designs/design", design: design)
end