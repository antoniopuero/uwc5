define 'getCarView', [
  'cs!modalView'
  'cs!createOrderView'
  'cs!order'
  'marionette'
  'jquery'
], (modalView, CreateOrderView, Order, Marionette, $) ->
  class GetCarView extends CreateOrderView
    template: '#get-car-template'
    events: ->
      'click .send': 'send'
    initialize: ->
      $.validator.addMethod 'mobilephone', (value, element) ->
        this.optional(element) || /^(?:\+\d{2})?\d{10}$/.test(value)
      , 'Please, enter a valid phone number! ( +380... or 0653..)'
      super()

    onShow: ->
      @$el.find('form').validate rules:
        startplace:
          required: true
        endplace:
          required: true
        date:
          required: true
        phone:
          required: true
          mobilephone: true
      super()

    send: (e) ->
      e.preventDefault()
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
        date: @ui.date.val()

      data

    resetForm: ->
      @ui.startPlace.val('')
      @ui.endPlace.val('')
      @ui.phone.val('')
      @ui.date.val('')

  GetCarView