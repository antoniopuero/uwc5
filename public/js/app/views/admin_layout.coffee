define 'adminLayout', [
  'cs!cars'
  'cs!orders'
  'cs!order'
  'cs!carMapView'
  'cs!carListView'
  'cs!/js/app/views/OrderListView'
  'cs!/js/app/views/CreateOrderView'
  'marionette'
], (Cars, Orders, Order, CarMapView, CarListView, OrderListView, CreateOrderView) ->
  class AdminLayout extends Marionette.Layout
    template: '#admin-template'

    initialize: ->
    events:
      'click .js-edit': 'editLine'

    regions:
      map: '#map'
      orders: "#orders"
      cars: "#cars"
      createOrder: "#create-order"

    onShow: ->
      cars = new Cars
      orders = new Orders

      @createMap()

      @orders.show new OrderListView collection: orders
      @map.show new CarMapView collection: cars
      @cars.show new CarListView collection: cars
      @createOrder.show new CreateOrderView collection: orders

      App.socket.on 'order-create', (data) ->
        orders.add new Order(data)

      App.socket.on 'order-delete', (data) ->
        orders.remove new Order(data)

      cars.fetch reset: true
      orders.fetch reset: true

    createMap: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      mapDiv = document.getElementById('map')
      App.map = new google.maps.Map(mapDiv, mapOptions)

    editLine: ->
      App.map.line.setEditable(true) if App.map.line
      console.log 'edit line'




  AdminLayout
