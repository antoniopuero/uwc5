define ['text!/js/app/templates/order.html'], (orderTemplate) ->
  Marionette.ItemView.extend
    tagName: 'tr'
    template: orderTemplate

    events:
      'click .delete': 'destroy'

    destroy: ->
      @model.destroy()
