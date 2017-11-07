json.(@design)
json.cache! [design] do
  json.partial! "spree/api/designs/design", design: design
end
