define 'carMapView', ['marionette'], (Marionette) ->
  class CarMapView extends Marionette.CompositeView
    template: _.template('')
    id: 'car-map'

    onRender: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP

      @map = new google.maps.Map(@el, mapOptions)

    appendHtml: (collectionView, itemView, index) ->
      car = itemView.model
      p = car.get('point')
      car.marker = new google.maps.Marker
        position: new google.maps.LatLng p[0], p[1]
        map: @map
        title: car.get('driverName')

  CarMapView