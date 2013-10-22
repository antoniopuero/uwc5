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

    ui:
      startPlace: 'input[name="startPlace"]'
      endPlace: 'input[name="endPlace"]'
      price: 'input[name="price"]'
      date: 'input[name="date"]'
      name: 'input[name="clientName"]'

    initialize: ->

    onShow: ->
      @initSearch()

    toggleForm: ->
      @$el.find('form').toggle();
      @$el.find('.well').toggle();

    createOrder: ->
      orderData =
        startPointTitle: @ui.startPlace.val()
        endPointTitle: @ui.endPlace.val()
        price: @ui.price.val()
        name: 'not loggined'
        date: @ui.date.val()
        startPoint: [30, 40]
        endPoint: [25, 34]

      order = new Order orderData
      order.save {},
        success: =>
          @collection.add order
          @toggleForm()
          
      @ui.startPlace.val('')
      @ui.endPlace.val('')
      @ui.price.val('')
      @ui.date.val('')
      @ui.name.val('')


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
            #geocoder.geocode { address: item }, (results, status) =>
            
            item;


           