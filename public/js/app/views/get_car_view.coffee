define 'getCarView', ['cs!createOrderView', 'cs!order', 'marionette'], (CreateOrderView, Order, Marionette) ->
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
            alert @model.get('price')
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