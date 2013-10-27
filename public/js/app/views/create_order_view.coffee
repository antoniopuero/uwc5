define [
  'cs!orderView',
  'cs!orderListView',
  'cs!order',
  'marionette',
  'inputmask',
  'timepicker'
], (OrderView, OrderListView,Order, Marionette) ->
  class CreateOrderView extends Marionette.ItemView
    template: '#create-order-template'

    events:
      "click .js-save-order": "saveOrder"
      "click .js-cancel-order": "cancelOrder"
      "click .js-calculate-order": "calculateDuration"
      "click .js-next-path": "nextPath"
      "click .js-create-order": "createOrder"
      "click .js-hide-error": "hideError"

    ui:
      startPlace: 'input[name="startPlace"]'
      endPlace: 'input[name="endPlace"]'
      price: 'input[name="price"]'
      date: 'input[name="date"]'
      phone: 'input[name="phone"]'
      errorProvider: '.js-error-provider'

    initialize: ->
      @geocoder = new google.maps.Geocoder()
      @directionsService = new google.maps.DirectionsService()

    onShow: ->
      @initSearch()


      if @ui.phone.length
        @ui.phone.inputmask mask : "(099)-999-99-99"

      if @ui.date.length
        @ui.date.timepicker showMeridian: false



      # @createOrder()
      # @calculateDuration()

    hideError: ->
      @ui.errorProvider.hide()

    errorProvider: (msg) ->
      @ui.errorProvider.find('.js-error-text').html msg
      @ui.errorProvider.show()

    createOrder: ->
      @toggleForm()
      @model = new Order

      @model.on 'change:price', (model, price) =>
        @ui.price.val price + ' грн'

      @model.on 'invalid', (model, error) =>
        @errorProvider error

    calculateDuration: (callback) ->
      unless @ui.endPlace.val() && @ui.startPlace.val()
        @errorProvider 'Set START and DEST points'
        return

      jQuery.when(
        @getLatLngFromAddress(@ui.endPlace.val()),
        @getLatLngFromAddress(@ui.startPlace.val()),
      ).done((endLatLng, startLatLng) =>
        @getPathBetweenPoints startLatLng, endLatLng, (distanceResult, status) =>
          unless status is 'OK'
            return @errorProvider status + ': cannot create route between this points'

          modelData = {}

          unless startLatLng && endLatLng && distanceResult &&
            (modelData.startPoint = @retrievePoint(startLatLng)) &&
            (modelData.endPoint = @retrievePoint(endLatLng)) &&
            (modelData.path = @retrievePath distanceResult.routes[0].overview_path) &&
            (modelData.distance = distanceResult.routes[0].legs[0].distance.value) &&
            (modelData.price = @retrievePrice(modelData.distance))
              @errorProvider 'Can not buid rout between points'
              return
          else
            @model.set modelData

          OrderListView.drawOrderPath @model

          @ui.errorProvider.hide()

          if typeof callback is 'function'
            callback()
      ).fail () =>
        @errorProvider 'Не удалось определить место'

    clearLine: ->
      App.map.line.setMap null

    saveOrder: ->
      @model.set @prepareModelData()
      @model.save @model.toJSON(),
        success: =>
          @collection.push @model
          @toggleForm()
          @resetForm()
          @ui.errorProvider.hide()
          @clearLine()

    cancelOrder: ->
      @toggleForm()
      @model.destroy()
      @clearLine()

    prepareModelData: ->
      data = {}
      data.startPointTitle = @ui.startPlace.val()
      data.endPointTitle = @ui.endPlace.val()
      data.phone = @ui.phone.val()
      data.price = parseInt @ui.price.val(), 10
      data.date = @ui.date.val()

      data

    toggleForm: ->
      @$el.find('form').toggle();
      @$el.find('.well').toggle();

    nextPath: ->

    getLatLngFromAddress: (address) ->
      deferred = new jQuery.Deferred()
      @geocoder.geocode address: address + ' Киев', region: 'ua', language: 'ru', (results, status) =>
        unless status is 'OK'
          return deferred.reject status

        unless results[0]?.geometry?.location?
          return deferred.reject 'Coordinates of addres not found'

        deferred.resolve results[0].geometry.location

      deferred

    getPathBetweenPoints: (startLatLng, endLatLng, callback) ->
      @directionsService.route {
        origin: startLatLng
        destination: endLatLng
        travelMode: google.maps.TravelMode.DRIVING
        provideRouteAlternatives: true
        }, callback

    retrievePoint: (latLng) ->
      [latLng.jb, latLng.kb]

    retrievePath: (googlePathList) ->
      _.map googlePathList, (latLng) =>
        @retrievePoint latLng

    retrievePrice: (distance) ->
      price = Math.round distance / 1000 * 2 + 25 # 25 uah by default + 2 uah for kilommeter
      price

    initSearch: ->
      @searchInput = @$(".typeahead")

      geocoder = new google.maps.Geocoder()
      service = new google.maps.places.AutocompleteService()

      @searchInput.typeahead
        source: (query, process) =>
          service.getPlacePredictions {
            input: query
            componentRestrictions: { country: 'ua' }
          }, (predictions, status) =>
            if status is google.maps.places.PlacesServiceStatus.OK
              process($.map predictions, (prediction) =>
                prediction.description.split(',')[0]
              )
        updater: (item) =>
          #geocoder.geocode { address: item }, (results, status) =>

            item

    resetForm: ->
      @ui.startPlace.val('')
      @ui.endPlace.val('')
      @ui.price.val('')
      @ui.date.val('')
      @ui.phone.val('')


  CreateOrderView
