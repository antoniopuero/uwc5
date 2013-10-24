define ['cs!/js/app/views/OrderView'], (OrderView) ->
  Marionette.CollectionView.extend
    itemView: OrderView
    tagName: 'table'
    className: 'table table-bordered table-striped table-hover'

    onShow: ->
      @initOrderEvents()

    initOrderEvents: ->
      @listenTo @collection, 'click', (order) ->
        console.log @
        console.log arguments
        @drawOrderPath(order)

    drawOrderPath: (order)->
      updatePath = =>
        # @model.updatePathFromGoogle @line.getPath().getArray()

      if App.map.line then App.map.line.setMap null
      App.map.line = new google.maps.Polyline
        path: order.pathToGoogle()
        geodesic: true
        strokeColor: '#FF0000'
        strokeOpacity: 1.0
        strokeWeight: 2

      App.map.line.setEditable(true)
      google.maps.event.addListener App.map.line.getPath(), "set_at", updatePath
      google.maps.event.addListener App.map.line.getPath(), "insert_at", updatePath
      google.maps.event.addListener App.map.line.getPath(), "remove_at", updatePath

      App.map.line.setMap App.map
