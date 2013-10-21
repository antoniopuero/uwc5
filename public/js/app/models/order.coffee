define 'order', ['backbone'], (Backbone) ->
  class Order extends Backbone.Model
    idAttribute: '_id'

  Order