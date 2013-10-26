define 'orders', ['backbone', 'cs!order'], (Backbone, Order)->
    class Orders extends Backbone.Collection
        model: Order
        url: 'api/orders'

        comparator: (order) ->
            if order.get('status') is 'ready'
                return 1
            if order.get('status') is 'assigned'
                return 2
            if order.get('status') is 'completed'
                return 3

        parse: (attrs, options) ->
            if attrs.result
                attrs = attrs.result

            super attrs, options

    Orders