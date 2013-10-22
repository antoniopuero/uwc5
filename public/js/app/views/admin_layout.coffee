define 'adminLayout', ['marionette', 'cs!carMapView'], (Marionette, CarMapView) ->
  class AdminLayout extends Marionette.Layout
    template: '#admin-template'

    regions:
      carMap: '#car-map-wrap'

    onRender: ->
      @carMap.show new CarMapView

  AdminLayout
