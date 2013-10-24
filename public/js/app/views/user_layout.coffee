define 'userLayout', [
  'cs!cars'
  'cs!getCarView'
  'cs!carMapView'
  'marionette'
], (Cars, GetCarView, CarMapView, Marionette) ->
  class UserLayout extends Marionette.Layout
    template: '#user-template'

    regions:
      map: '#map'
      getCar: "#get-car"

    onShow: ->
      cars = new Cars

      @createMap()

      @map.show new CarMapView collection: cars
      @getCar.show new GetCarView

      cars.fetch reset: true

    createMap: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      mapDiv = document.getElementById('map')
      App.map = new google.maps.Map(mapDiv, mapOptions)

  UserLayout
