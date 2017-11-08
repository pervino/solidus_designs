json.(@template_design)
json.cache! [template_design] do
  json.partial!("spree/api/template_designs/template_design", template_design: template_design)
end