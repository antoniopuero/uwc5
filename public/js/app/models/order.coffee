define ['backbone'], (Backbone) ->
  class Order extends Backbone.Model
    idAttribute: '_id'
    url: ->
        url = '/api/orders'
        unless @isNew() then url += '/' + @id
        url

    parse: (attrs, options) ->
        if attrs.result?
            attrs = attrs.result

        super attrs, options

    validate: (attrs, options) ->
        isValid = true
        requiredFields = ['startPointTitle', 'endPointTitle', 'startPoint', 'endPoint','distance', 'price', 'date', 'name']

        _.each requiredFields, (attr) =>
            unless @get(attr)
                isValid = false

        if isValid then return false else return 'FILL all form fields or CALCULATE route'

  Order