json.cache! [I18n.locale, template_design] do
  json.partial!("spree/api/designs/design", design: template_design)
end