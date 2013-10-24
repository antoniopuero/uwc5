define ['cs!/js/app/views/OrderView'], (OrderView) ->
  class OrderListView extends Marionette.CollectionView
    itemView: OrderView
    tagName: 'table'
    className: 'table table-condensed table-bordered table-hover order-table'
    # attributes:
    #   'contenteditable': true

    onShow: ->
      @initOrderEvents()
      console.log OrderView

    initOrderEvents: ->
      @listenTo @collection, 'click', (order) ->
        OrderListView.drawOrderPath(order)

    @drawOrderPath: (order)->
      updatePath = ->
        console.log 'update path'
        order.updatePathFromGoogle App.map.line.getPath().getArray()

        order.on 'invalid', (model, error) ->

          console.log arguments

        order.save()

      clearMap = ->
        if App.map.line then App.map.line.setMap null
        if App.map.startPoint then App.map.startPoint.setMap null
        if App.map.endPoint then App.map.endPoint.setMap null

      subscribeToWaypoints = ->
        google.maps.event.addListener App.map.line.getPath(), "set_at", updatePath
        google.maps.event.addListener App.map.line.getPath(), "insert_at", updatePath
        google.maps.event.addListener App.map.line.getPath(), "remove_at", updatePath

      polylineOptions =
        path: order.pathToGoogle()
        geodesic: true
        strokeColor: '#FF0000'
        strokeOpacity: 0.8
        strokeWeight: 4
        editable: false
        map: App.map

      startPointOptions =
        position: new google.maps.LatLng order.get('startPoint')[0], order.get('startPoint')[1]
        map: App.map
        icon:
          url: '/i/start.png'
          size:
            width: 50
            height: 30

      endPointOptions =
        position: new google.maps.LatLng order.get('endPoint')[0], order.get('endPoint')[1]
        map: App.map
        icon:
          url: '/i/finish.png'
          size:
            width: 66
            height: 28

      clearMap()

      App.map.line = new google.maps.Polyline polylineOptions
      App.map.startPoint = new google.maps.Marker startPointOptions
      App.map.endPoint = new google.maps.Marker endPointOptions

      subscribeToWaypoints()

      startLatLng = new google.maps.LatLng order.get('startPoint')[0], order.get('startPoint')[1]
      endLatLng = new google.maps.LatLng order.get('endPoint')[0], order.get('endPoint')[1]

      bound = new google.maps.LatLngBounds()

      bound.extend startLatLng
      bound.extend endLatLng

      App.map.fitBounds bound
