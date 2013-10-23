define 'carMapView', ['marionette', 'cs!carView'], (Marionette, CarView) ->
  class CarMapView extends Marionette.CollectionView
    id: 'car-map'
    itemView: CarView

    initialize: ->
      @points = []
      console.log 'car-map'

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

    onBeforeRender: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      @map = new google.maps.Map(@el, mapOptions)

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