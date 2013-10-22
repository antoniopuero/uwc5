define ['backbone'], (Backbone) ->
  class Order extends Backbone.Model
    idAttribute: '_id'
    url: ->
        url = '/api/orders'
        unless @isNew() then url += '/' + @id
        url

  Order