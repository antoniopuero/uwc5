define 'orders', ['backbone', 'cs!order'], (Backbone, Order)->
  class Orders extends Backbone.Collection
    model: Order
    url: 'api/orders'

    parse: (resp) ->
      resp.result

  Orders