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
      adminForm: "#admin-form"

    onRender: ->
      cars = new Cars
      orders = new Orders

      #@orders.show new OrderListView collection: orders
      #@adminForm.show new CreateOrderView collection: orders
      @carMap.show new CarMapView

      cars.fetch reset: true
      orders.fetch reset: true

  AdminLayout
