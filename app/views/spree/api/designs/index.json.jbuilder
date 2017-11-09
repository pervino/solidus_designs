json.designs(@designs) do |design|
  json.partial!("spree/api/designs/design", design: design)
end

json.count(@designs.count)
json.current_page(params[:page] || 1)
json.pages(@designs.total_pages)
