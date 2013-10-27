define [
  'cs!userLayout'
  'cs!cars'
  'cs!myOrders'
  'cs!carMapView'
  'cs!userOrdersView'
], (UserLayout, Cars, MyOrders, CarMapView, UserOrdersView) ->
  class UserOrdersLayout extends UserLayout
    template: '#user-orders-template'
    id: 'user-orders'

    initialize: ->
      @cars = new Cars
      @orders = new MyOrders
      @initApplyOrderEvents()

    regions:
      map: '#map'
      ordersEl: "#orders"

    onShow: ->
      @map.show new CarMapView collection: @cars
      @ordersEl.show new UserOrdersView collection: @orders

      @createMap()
      @orders.fetch reset: true

    initApplyOrderEvents: ->
      @listenTo @orders, 'change:selected', (order) =>
        @selectedOrder.set 'selected', false if @selectedOrder
        @selectedOrder = order

  UserOrdersLayout