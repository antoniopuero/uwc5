define 'car', ['backbone'], (Backbone) ->
  class Car extends Backbone.Model
    idAttribute: '_id'

  Car