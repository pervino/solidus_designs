object false

child(@templates => :templates) do
    attributes *template_attributes

    node :images do |joined_template|
      design = Spree::Design.find(joined_template.design_id)

      {
        small: design.rendering.url(:small),
        medium: design.rendering.url(:medium)
      }
    end
end

# node(:count) { @templates.count }
node(:current_page) { params[:page] || 1 }
node(:pages) { @templates.num_pages }