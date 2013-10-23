define 'adminLayout', [
  'cs!cars'
  'cs!orders'
  'cs!carMapView'
  'cs!carListView'
  'cs!/js/app/views/OrderListView'
  'cs!/js/app/views/CreateOrderView'
  'marionette'
], (Cars, Orders, CarMapView, CarListView, OrderListView, CreateOrderView) ->
  class AdminLayout extends Marionette.Layout
    template: '#admin-template'

    initialize: ->
      console.log 'init layout'

    regions:
      carMap: '#car-map-wrap'
      orders: "#orders"
      cars: "#cars"
      createOrder: "#create-order"

    onRender: ->
      cars = new Cars
      orders = new Orders

      @orders.show new OrderListView collection: orders
      @carMap.show new CarMapView collection: cars
      @cars.show new CarListView collection: cars
      @createOrder.show new CreateOrderView collection: orders

      cars.fetch reset: true
      orders.fetch reset: true

  AdminLayout
