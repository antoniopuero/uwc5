define 'loggerView', [
  'marionette'
], () ->
  Marionette.ItemView.extend
    template: '#side-logger'

    initialize: ->
      events:
        'click .triangle-button': 'toggleLogger'

    toggleLogger: ->
      log = @$el.find('.log-text')
      width = log.width()
      if log.hasClass('shown')
        @$el.animate(left: -width, 500)
        log.removeClass('shown')
      else
        @$el.animate(left: 0, 500)
        log.addClass('shown')
