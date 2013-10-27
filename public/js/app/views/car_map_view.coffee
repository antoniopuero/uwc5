define ['marionette', 'cs!dummyView'], (Marionette, DummyView) ->
  class CarMapView extends Marionette.CollectionView
    id: 'car-map'
    itemView: DummyView

    initialize: ->
      @points = []
      @listenTo @collection, 'add remove change:point', @render

    renderPoints: ->
      _.each @points, (point) =>
        car = point.car

        if point.marker
          point.marker.setMap(null)
          point.marker = null

        p = car.get('point')
        options =
          position: new google.maps.LatLng p[0], p[1]
          map: @map
          title: car.get('driverName')
          #icon: '/i/taxi.png'

        if point.highlight
          options.animation = google.maps.Animation.BOUNCE
          point.highlight = false

        point.marker = new google.maps.Marker options

        google.maps.event.addListener point.marker, 'mouseover', ->
          point.car.trigger('mouseover-on-map')

        google.maps.event.addListener point.marker, 'mouseout', ->
          point.car.trigger('mouseout-on-map')

        google.maps.event.addListener point.marker, 'click', ->
          point.car.set 'selected', true

    onBeforeRender: ->
      @map = App.map

    onRender: ->
      @renderPoints()

    onBeforeItemAdded: (itemView) ->
      car = itemView.model

      point =
        car: car
        highlight: false

      @listenTo car, 'highlight', =>
        point.highlight = true
        @renderPoints()

      @listenTo car, 'unhighlight', =>
        point.highlight = false
        @renderPoints()

      @points.push point

    appendHtml: (collectionView, itemView, index) -> null

  CarMapView