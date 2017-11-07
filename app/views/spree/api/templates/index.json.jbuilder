json.templates @templates do |json, template|
  json.partial! "spree/api/templates/template", template: template
end

json.count @templates.count
json.current_page params[:page] || 1
json.pages @templates.total_pages