define ['text!/js/app/templates/order.html'], (orderTemplate) ->
  Marionette.ItemView.extend
    tagName: 'tr'
    className: ->
      if @model.get('status') is 'ready'
        return 'error'
      if @model.get('status') is 'assiged'
        return 'warning'
      if @model.get('status') is 'completed'
        return 'success'

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
