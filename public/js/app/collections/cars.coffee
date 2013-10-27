define 'cars', ['backbone', 'cs!car'], (Backbone, Car)->
  class Cars extends Backbone.Collection
    model: Car
    url: 'api/cars'

    parse: (attrs, options) ->
        if attrs.result
            attrs = attrs.result

        super attrs, options

    comparator: (order) ->
        if order.get('status') is 'ready'
            return 1
        if order.get('status') is 'busy'
            return 2
        if order.get('status') is 'off'
            return 3

  Cars