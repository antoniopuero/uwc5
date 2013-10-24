define 'orders', ['backbone', 'cs!order'], (Backbone, Order)->
  class Orders extends Backbone.Collection
    model: Order
    url: 'api/orders'

    parse: (attrs, options) ->
      if attrs.result
        attrs = attrs.result

      super attrs, options

  Orders