define 'carListView', ['marionette', 'cs!carView'], (Marionette, CarView) ->
  class CarListView extends Marionette.CollectionView
    itemView: CarView
    tagName: 'table'
    className: 'table table-bordered table-striped table-hover'

  CarListView