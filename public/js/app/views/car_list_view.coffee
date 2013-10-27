define 'carListView', ['marionette', 'cs!carView'], (Marionette, CarView) ->
  class CarListView extends Marionette.CompositeView

    initialize: ->
      @listenTo @collection, 'change:status', () ->
        @collection.sort()
        @render()

    itemView: CarView
    # tagName: 'table'
    # className: 'table table-bordered table-condensed table-hover'
    itemViewContainer: "tbody"
    template: "#car-liste"

  CarListView