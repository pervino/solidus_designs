object false
child(@designs => :designs) do
  extends "spree/api/designs/design"
end
node(:count) { @designs.count }
node(:current_page) { params[:page] || 1 }
node(:pages) { @designs.total_pages }
