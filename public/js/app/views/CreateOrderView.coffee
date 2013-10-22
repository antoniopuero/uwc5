define [
  'cs!/js/app/views/OrderView'
  'cs!order'
], (OrderView, Order) ->
  Marionette.ItemView.extend
    template: '#create-order-template'

    events:
      "click .js-create-order": "createOrder"
      "click .js-cancel-order": "toggleForm"
      "click .js-show-form": "toggleForm"

    initialize: ->
      @initSearch()

    onShow: ->
      @initSearch()

    toggleForm: ->
      @$el.find('form').toggle();
      @$el.find('.well').toggle();

    createOrder: ->
      orderData =
        startPointTitle: @$el.find('input[name="startPlace"]').val()
        endPointTitle: @$el.find('input[name="endPlace"]').val()
        price: @$el.find('input[name="price"]').val()
        name: 'not loggined'
        date: @$el.find('input[name="date"]').val()
        startPoint: [30, 40]
        endPoint: [25, 34]

      order = new Order orderData
      order.save {},
        success: =>
          @collection.add order
          @toggleForm()

    initSearch: ->
      @searchInput = $(".typeahead", @$el)

      geocoder = new google.maps.Geocoder()
      service = new google.maps.places.AutocompleteService()

      @searchInput.typeahead
          source: (query, process) =>
            service.getPlacePredictions { input: query }, (predictions, status) =>
              if status is google.maps.places.PlacesServiceStatus.OK
                process($.map predictions, (prediction) =>
                  prediction.description
                )
          updater: (item) =>
            geocoder.geocode { address: item }, (results, status) =>
            #   # if (status == google.maps.GeocoderStatus.OK)
            #     # @map.fitBounds(results[0].geometry.viewport)
            #     # @searchInput.val('')
            item;
