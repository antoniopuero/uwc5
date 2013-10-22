define [
  'cs!/js/app/views/OrderView'
  'cs!order'
], (OrderView, Order) ->
  Marionette.ItemView.extend
    template: '#create-order-template'

    events:
      "click .js-create-order": "createOrder"

    initialize: ->
      console.log Order

    createOrder: ->
      orderData =
        startPointTitle: @$el.find('input[name="startPlace"]').val()
        endPointTitle: @$el.find('input[name="endPlace"]').val()
        price: @$el.find('input[name="price"]').val()
        name: 'not loggined'
        date: @$el.find('input[name="date"]').val()
        startPoint: [30, 40]
        endPoint: [25, 34]

      order = new Order orderData
      @collection.add order
      order.save()
