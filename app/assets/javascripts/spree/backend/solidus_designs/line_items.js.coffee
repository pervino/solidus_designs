editingDone = (e) ->
  e.preventDefault()
  $(e.delegateTarget).removeClass('editing')

onSaveLineItem = (e) ->
  e.preventDefault()
  line_item = $(this).closest('.line-item')
  line_item_id = line_item.data('line-item-id')
  quantity = parseInt(line_item.find('input.line_item_quantity').val())
  price = parseFloat(line_item.find('input.line_item_price').val())
  adjustLineItem(line_item_id, quantity, price)
  editingDone(e)

onAddCustomization = (e) ->
  e.preventDefault()
  line_item = $(this).closest('.line-item')
  line_item_id = line_item.data('line-item-id')
  quantity = parseInt(line_item.find('input.line_item_quantity').val())
  price = parseFloat(line_item.find('input.line_item_price').val())
  medium = $(this).data('medium')
  size = $(this).data('size')
  configuration_id = $(this).data('configuration-id')
  source_id = $(this).data('source-id')
  user_id = $(this).data('user-id')
  Routine.SelectDesign medium, size, user_id, (design) ->
    addCustomization(line_item_id, quantity, price, design, configuration_id, source_id)

onEditCustomization = (e) ->
  e.preventDefault()
  line_item = $(this).closest('.line-item')
  line_item_id = line_item.data('line-item-id');
  design_id = $(this).data('design-id')
  customization_id = $(this).data('customization-id')
  user_id = $(this).data('user-id')
  Routine.CreateDesign design_id, user_id, (design) ->
    data =
      article_id: design.id
    updateCustomization(line_item_id, customization_id, data)

onChangeCustomization = (e) ->
  e.preventDefault()
  line_item = $(this).closest('.line-item')
  line_item_id = line_item.data('line-item-id')
  quantity = parseInt(line_item.find('input.line_item_quantity').val())
  price = parseFloat(line_item.find('input.line_item_price').val())
  medium = $(this).data('medium')
  size = $(this).data('size')
  customization_id = $(this).data('customization-id')
  user_id = $(this).data('user-id')
  Routine.SelectDesign medium, size, user_id, (design) ->
    data =
      article_id: design.id
    updateCustomization(line_item_id, customization_id, data)

onCheckNonStandard = (e) ->
  e.preventDefault()
  line_item = $(this).closest('.line-item')
  line_item_id = line_item.data('line-item-id')
  customization_id = $(this).data('customization-id')
  api = new Api.Spree.Customization()
  data =
    is_non_standard: $(e.target).is(":checked")
  updateCustomization(line_item_id, customization_id, data)


$(document).ready ->
  $('.line-items')
  .on('click', '.add-customization', onAddCustomization)
  .on('click', '.edit-customization', onEditCustomization)
  .on('click', '.change-customization', onChangeCustomization)
  .on('click', '.solidus-designs-save-line-item', onSaveLineItem)
  .on('change', '.toggle-customization-non-standard', onCheckNonStandard)


lineItemURL = (id) ->
  "#{Spree.routes.line_items_api(order_number)}/#{id}.json"

customizationUrl = (line_item_id, id) ->
  "#{Spree.routes.customizations_api(line_item_id)}/#{id}.json"


adjustLineItem = (line_item_id, quantity, price) ->
  url = lineItemURL(line_item_id)
  Spree.ajax(
    type: "PUT",
    url: url,
    data:
      line_item:
        quantity: quantity
        options:
          price: price
  ).done (msg) ->
    window.Spree.advanceOrder()

addCustomization = (line_item_id, quantity, price, design, configuration_id, source_id) ->
  url = lineItemURL(line_item_id)
  data = JSON.stringify(
    line_item:
      quantity: quantity
      options:
        price: price
        customizations_attributes: [
          article_id: design.id
          article_type: 'Spree::Design'
          configuration_id: configuration_id
          configuration_type: 'Spree::DesignConfiguration'
          source_id: source_id
          source_type: 'Spree::DesignOption'
        ]
  )
  Spree.ajax(
    type: "PUT",
    url: url,
    contentType: "application/json"
    data: data
  ).done (msg) ->
    window.location.reload()

updateCustomization = (line_item_id, customization_id, data) ->
  url = customizationUrl(line_item_id, customization_id)
  Spree.ajax(
    type: "PUT",
    url: url,
    data:
      customization: data
  ).done (msg) ->
    window.location.reload()
