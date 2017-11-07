json.(@template, *template_attributes)

json.designs @template.designs do |json, design|
  json.partial! "spree/api/designs/show", design: design
end