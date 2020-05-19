onCloneDesign = (e) ->
  e.preventDefault()
  design_id = $(this).data('design-id')
  user_id = $(this).data('user-id')
  
  Routine.CreateDesign design_id, user_id, (design) ->
    window.location.reload()

onDeleteDesign = (e) ->
  e.preventDefault()
  design_id = $(this).data('design-id')
  deleteDesign(design_id)

onEditDesign = (e) ->
  e.preventDefault()
  design_id = $(e.target).data("design-id")
  
  # request to get design
  # sourceDesign = thing
  req = Api.Pervino.Design.show design_id, {}
  req.done (sourceDesign) ->
    onSave = (markup, url) ->
      design = {
        markup: markup,
        full: url,
        size: sourceDesign.size,
        template_id: sourceDesign.template_id,
        medium: sourceDesign.medium,
        source_id: sourceDesign.id
      }

      req = Api.Pervino.Design.update design_id, design, {}
      req.done (design) ->
        window.location.reload()
      
    designer.init({ design: sourceDesign, sku: settings.sku, onSave }) 

$(document).ready ->
  $('.designs')
  .on('click', '.clone-design', onCloneDesign)
  .on('click', '.delete-design', onDeleteDesign)
  .on('click', '.edit-design', onEditDesign)

designUrl = (id) ->
  "#{Spree.routes.designs_api()}/#{id}.json"


deleteDesign = (id) ->
  url = designUrl(id)
  Spree.ajax(
    type: "DELETE",
    url: url,
    data:
      design:
        id: id
  ).done (msg) ->
    window.location.reload()