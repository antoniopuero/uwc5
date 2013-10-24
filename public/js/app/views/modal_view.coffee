define 'modalView', ['marionette', 'text!/js/app/templates/modal.html'], (Marionette, modalTemplate) ->
  class modalView extends Marionette.ItemView
    className: 'modal hide fade'
    template: modalTemplate
    onShow: ->
      @$el.modal()

  modalView