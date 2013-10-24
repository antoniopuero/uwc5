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

    initialize: ->
        @on 'change:path', () ->
            @updatePrice()

    pathToGoogle: (path) ->
        path = @get("path") unless path
        result = []
        _.each path, (position) ->
            result.push new google.maps.LatLng(position[0], position[1])
        result

    pathFromGoogle: (googlePath) ->
        result = []
        _.each googlePath, (position) ->
            console.log position.jb
            result.push [position.jb, position.kb]
        result

    updatePrice: ->
        distance = 0
        path = @get "path"
        i = 1
        while i < path.length
            start = path[i - 1]
            end = path[i]
            distance += google.maps.geometry.spherical.computeDistanceBetween(new google.maps.LatLng(start[0], start[1]), new google.maps.LatLng(end[0], end[1]))
            ++i

        @set "price", Math.round(25 + distance / 1000 * 2)

    updatePathFromGoogle: (googlePath) ->
        path = @pathFromGoogle(googlePath)
        @set "path", path

  Order