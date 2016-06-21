@SelectDesign = (medium, size, user_id, callback) ->
  props =
    medium: medium,
    size: size

  modalSettings =
    modalClasses: 'modal-lg'
    modalStyles: {height: "80vh"}

  routineCallbacks =
    select: (design) ->
      callback design
    create: (sourceDesign) ->
      CreateDesign sourceDesign.id, user_id, (design) ->
        callback design

  new IframeModalLauncher('/components/select_design', props, routineCallbacks, modalSettings)


@CreateDesign = (source_design_id, user_id, callback) ->
  modalSettings =
    modalClasses: 'modal-lg'

  routineCallbacks =
    save: (rawDesign, sourceDesign) ->
      req = Api.Pervino.Design.create rawDesign, sourceDesign, user_id
      req.done (data) ->
        callback data

  new IframeModalLauncher('/components/create_design', design_id: source_design_id, routineCallbacks, modalSettings)