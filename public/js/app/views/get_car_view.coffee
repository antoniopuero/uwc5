define 'getCarView', [
  'cs!modalView'
  'cs!createOrderView'
  'cs!order'
  'marionette'
], (modalView, CreateOrderView, Order, Marionette) ->
  class GetCarView extends CreateOrderView
    template: '#get-car-template'
    events: ->
      'click .send': 'send'

    send: ->
      @model = new Order
      @calculateDuration =>
        @model.set @prepareModelData()
        @model.save @model.toJSON(),
          validate: false
          success: =>
            App.layout.modal.show new modalView(model: @model)
            @resetForm()

    prepareModelData: ->
      data =
        startPointTitle: @ui.startPlace.val()
        endPointTitle: @ui.endPlace.val()
        phone: @ui.phone.val()

      data

    resetForm: ->
      @ui.startPlace.val('')
      @ui.endPlace.val('')
      @ui.phone.val('')

  GetCarView