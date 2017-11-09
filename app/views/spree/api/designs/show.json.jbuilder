json.cache! [design] do
  json.(design)
  json.partial!("spree/api/designs/design", design: design)
end
