define ['backbone', 'cs!orders'], (Backbone, Orders)->
  class MyOrders extends Orders
    url: 'api/myorders'

  MyOrders