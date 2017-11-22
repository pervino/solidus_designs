json.cache! [design_configuration] do
  json.(design_configuration, *design_configuration_attributes)
end

json.design_options(design_configuration.design_options) do |design_option|
  json.partial!("spree/api/design_options/design_option", design_option: design_option)
end