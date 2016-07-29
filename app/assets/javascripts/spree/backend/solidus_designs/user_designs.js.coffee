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

$(document).ready ->
  $('.designs')
  .on('click', '.clone-design', onCloneDesign)
  .on('click', '.delete-design', onDeleteDesign)

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