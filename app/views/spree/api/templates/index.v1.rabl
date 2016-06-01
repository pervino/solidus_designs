object false
child(@templates => :templates) do
  extends "spree/api/templates/template"
end
node(:count) { @templates.count }
node(:current_page) { params[:page] || 1 }
node(:pages) { @templates.num_pages }