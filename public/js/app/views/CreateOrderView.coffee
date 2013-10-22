define [
  'cs!/js/app/views/OrderView'
  'cs!order'
], (OrderView, Order) ->
  Marionette.ItemView.extend
    template: '#create-order-template'

    events:
      "click .js-create-order": "createOrder"

    ui:
      startPlace: 'input[name="startPlace"]'
      endPlace: 'input[name="endPlace"]'
      price: 'input[name="price"]'
      date: 'input[name="date"]'
      name: 'input[name="clientName"]'

    initialize: ->
      console.log Order

    createOrder: ->
      orderData =
        startPointTitle: @ui.startPlace.val()
        endPointTitle: @ui.endPlace.val()
        price: @ui.price.val()
        name: 'not loggined'
        date: @ui.date.val()
        startPoint: [30, 40]
        endPoint: [25, 34]

      order = new Order orderData
      @collection.add order
      order.save()

      @ui.startPlace.val('')
      @ui.endPlace.val('')
      @ui.price.val('')
      @ui.date.val('')
      @ui.name.val('')
