define 'userLayout', [
  'cs!cars'
  'cs!getCarView'
  'cs!carMapView'
  'marionette'
], (Cars, GetCarView, CarMapView, Marionette) ->
  class UserLayout extends Marionette.Layout
    template: '#user-template'

    initialize: ->
      @cars = new Cars

    regions:
      map: '#map'
      getCar: "#get-car"
      modal: "#modal"

    onShow: ->
      @map.show new CarMapView collection: @cars
      @getCar.show new GetCarView

      @createMap()
      @cars.fetch reset: true

    onClose: ->
      App.map = null

    createMap: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      mapDiv = @$('#car-map')[0]
      App.map = new google.maps.Map(mapDiv, mapOptions)

  UserLayout
