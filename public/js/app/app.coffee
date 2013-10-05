define ->
  initialize: ->
    console.log 'init'
    $('.dropdown-menu').find('form').on 'click', (e) ->
      e.stopPropagation()
