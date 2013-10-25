define 'userOrdersLayout', [
  'cs!userLayout'
  'cs!cars'
  'cs!myOrders'
  'cs!carMapView'
  'cs!userOrdersView'
  'marionette'
], (UserLayout, Cars, MyOrders, CarMapView, UserOrdersView, Marionette) ->
  class UserOrdersLayout extends UserLayout
    template: '#user-orders-template'
    id: 'user-orders'

    regions:
      map: '#map'
      orders: "#orders"

    onShow: ->
      cars = new Cars
      orders = new MyOrders

      @map.show new CarMapView collection: cars
      @orders.show new UserOrdersView collection: orders

      @createMap()
      orders.fetch reset: true

  UserOrdersLayout