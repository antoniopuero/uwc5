define 'carView', ['marionette', 'text!/js/app/templates/car.html'], (Marionette, carTemplate) ->
  class CarView extends Marionette.ItemView
    tagName: 'tr'
    template: carTemplate
    initialize: ->
      @listenTo @model, 'mouseover-on-map', =>
        @$el.addClass('hovered')

      @listenTo @model, 'mouseout-on-map', =>
        @$el.removeClass('hovered')

      @listenTo @model, 'change', (order) =>
        @render()

        if order.get('selected') is true
          @$el.addClass('selected')
        else
          @$el.removeClass('selected')

    events:
      mouseenter: 'highlight'
      mouseleave: 'unhighlight'
      click: 'click'
      keydown: 'keydown'

    highlight: -> @model.trigger 'highlight'

    unhighlight: -> @model.trigger 'unhighlight'

    keydown: ->
      console.log 'press'

    click: ->
      @model.set 'selected', true

    onRender: ->
      if @model.get('selected') is true
        @$el.addClass('selected')
      else
        @$el.removeClass('selected')

      if @model.get('status') is 'ready'
        @$el.addClass('success')

      if @model.get('status') is 'busy'
        @$el.addClass('warning')

      if @model.get('status') is 'off'
        @$el.addClass('grey')

  CarView