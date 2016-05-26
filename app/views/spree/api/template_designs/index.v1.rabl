object false
child(@template_designs => :template_designs) do
  extends "spree/api/template_designs/template_design"
end
node(:count) { @template_designs.count }
node(:current_page) { params[:page] || 1 }
node(:pages) { @template_designs.total_pages }
