json.cache! [template_design] do
  json.design do
    json.partial! "spree/api/designs/design", design: template_design
  end
end