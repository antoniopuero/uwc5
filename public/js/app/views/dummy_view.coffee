define ['marionette'], (Marionette) ->
  class DummyView extends Marionette.ItemView
    template: _.template('')

  DummyView