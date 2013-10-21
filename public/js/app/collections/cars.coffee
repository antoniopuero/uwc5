define 'cars', ['backbone', 'cs!car'], (Backbone, Car)->
  class Cars extends Backbone.Collection
    model: Car
    url: 'api/cars'

    parse: (resp) ->
      resp.result

  Cars