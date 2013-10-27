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
      'keydown input[name="date"]': 'fixTimePicker'

    initialize: ->
      $.validator.addMethod 'mobilephone', (value, element) ->
        this.optional(element) || /^\(0\d{2}\)-\d{3}-\d{2}-\d{2}$/.test(value)
      , 'Введите корректный номер телефона!'
      super()

    errorProvider: (msg) ->
      $('.js-error-provider').html msg
      $('.js-error-provider').show()

    onShow: ->
      @$('form').submit ->
        return false

      @$('form').validate
        messages:
          startPlace: 'Выберите место куда подать машину'
          endPlace: 'Выберите куда eхать'
          date: 'Выберите время подачи машины'
          phone: 'Введите корректный номер телефона'
        rules:
          startPlace:
            required: true
          endPlace:
            required: true
          date:
            required: true
          phone:
            required: true
            mobilephone: true
      super()

    send: (e) ->
      e.preventDefault()

      @$el.find('form').submit()
      if @$el.find('form').valid()
        $('.js-error-provider').hide()
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
      @ui.date.timepicker('setDefaultTime')

  GetCarView