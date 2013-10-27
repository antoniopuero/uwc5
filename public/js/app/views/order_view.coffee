define 'orderView', ['text!/js/app/templates/order.html', 'marionette'], (orderTemplate, Marionette) ->
  Marionette.ItemView.extend
    tagName: 'tr'

    template: orderTemplate

    # attributes:
    #   contenteditable: true

    initialize: ->
      @listenTo @model, 'change', @render

    onRender: ->
      if @model.get('selected') is true
        @$el.addClass('selected')
      else
        @$el.removeClass('selected')

      if @model.get('status') is 'ready'
        @$el.addClass('success')
      if @model.get('status') is 'processing'
        @$el.addClass('warning')
      if @model.get('status') is 'assigned'
        @$el.addClass('warning')
      if @model.get('status') is 'completed'
        @$el.addClass('error')

    events:
      'click .delete': 'destroy'
      'click .js-apply-first' : (e) ->
        e?.stopPropagation()
        @model.trigger 'apply-me', @model


      click: ->
        @model.set 'selected', true

      keydown: ->
        console.log 'press'

    destroy: ->
      @model.destroy()
