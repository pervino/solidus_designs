json.template_designs(@template_designs) do |template_design|
  json.partial!("spree/api/template_designs/template_design", template_design: template_design)
end

json.count(@template_designs.count)
json.current_page(params[:page] || 1)
json.pages(@template_designs.total_pages)
