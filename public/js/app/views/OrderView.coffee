define ['text!/js/app/templates/order.html'], (orderTemplate) ->
  Marionette.ItemView.extend
    tagName: 'tr'
    template: orderTemplate
    attributes:
      'contenteditable': true

    initialize: ->
    events:
      'click .delete': 'destroy'
      'click' : ->
        @model.trigger 'click', @model
      'keydown': ->
        console.log 'press'

    destroy: ->
      @model.destroy()
