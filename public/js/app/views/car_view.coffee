define 'carView', ['marionette', 'text!/js/app/templates/car.html'], (Marionette, carTemplate) ->
  class CarView extends Marionette.ItemView
    tagName: 'tr'
    template: carTemplate

    initialize: ->
      @listenTo @model, 'mouseover-on-map', =>
        @$el.addClass('selected')

      @listenTo @model, 'mouseout-on-map', =>
        @$el.removeClass('selected')

    events:
      mouseenter: 'highlight'
      mouseleave: 'unhighlight'

    highlight: -> @model.trigger 'highlight'
    unhighlight: -> @model.trigger 'unhighlight'

  CarView