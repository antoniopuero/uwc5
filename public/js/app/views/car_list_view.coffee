define 'carListView', ['marionette', 'cs!carView'], (Marionette, CarView) ->
  class CarListView extends Marionette.CompositeView
    itemView: CarView
    # tagName: 'table'
    # className: 'table table-bordered table-condensed table-hover'
    itemViewContainer: "tbody"
    template: "#car-liste"

  CarListView