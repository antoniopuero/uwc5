define 'carView', ['marionette', 'text!/js/app/templates/car.html'], (Marionette, carTemplate) ->
  class CarView extends Marionette.ItemView
    tagName: 'tr'
    template: carTemplate

    onRender: ->

  CarView