define 'adminLayout', [
  'cs!cars'
  'cs!orders'
  'cs!carMapView'
  'cs!/js/app/views/OrderListView'
  'cs!/js/app/views/CreateOrderView'
  'marionette'
], (Cars, Orders, CarMapView, OrderListView, CreateOrderView) ->
  class AdminLayout extends Marionette.Layout
    template: '#admin-template'

    regions:
      carMap: '#car-map-wrap'
      orders: "#orders"
      cars: "#cars"
      createOrder: "#create-order"

    onRender: ->
      cars = new Cars
      orders = new Orders

      @orders.show new OrderListView collection: orders
      @createOrder.show new CreateOrderView collection: orders
      @carMap.show new CarMapView

      cars.fetch reset: true
      orders.fetch reset: true

  AdminLayout
