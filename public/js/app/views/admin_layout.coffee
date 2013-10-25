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
      @cars = new Cars
      @orders = new Orders
      @initApplyOrderEvents()

      App.socket.on 'order-create', (data) =>
        @orders.add new Order(data)

      App.socket.on 'order-delete', (data) =>
        @orders.remove new Order(data)

    events:
      'click .js-edit-order-path': 'editOrderPath'
      'click .js-apply-order': 'applyOrder'

    regions:
      map: '#map'
      ordersReg: "#orders"
      carsReg: "#cars"
      createOrder: "#create-order"

    onShow: ->

      @createMap()

      @ordersReg.show new OrderListView collection: @orders
      @map.show new CarMapView collection: @cars
      @carsReg.show new CarListView collection: @cars
      @createOrder.show new CreateOrderView collection: @orders

      @cars.fetch reset: true
      @orders.fetch reset: true

    createMap: ->
      mapOptions =
        zoom: 11
        center: new google.maps.LatLng(50.44, 30.52)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false

      mapDiv = document.getElementById('map')
      App.map = new google.maps.Map(mapDiv, mapOptions)

    editOrderPath: ->
      App.map.line.setEditable(true) if App.map.line

    errorProvider: (error) ->
      alert error
    applyOrder: ->
      unless @selectedOrder? then return @errorProvider 'Выберите заказ, пожалуйста'
      unless @selectedCar? then return @errorProvider 'Выберите машину, пожалуйста'
      unless (@selectedOrder.get('status') is 'ready') then return @errorProvider 'Заказ должен быть свободным (зеленым)'
      unless (@selectedCar.get('status') is 'ready') then return @errorProvider 'Таксист должен быть онлайн и свободным (зеленым)'

      @selectedOrder.save
        selected: false
        status: 'assigned'
        carId: @selectedCar.get '_id'

      @selectedCar.save
        selected: false
        status: 'buisy'
        orderId: @selectedOrder.get '_id'

    applyOrderToTopCar: (order) ->
      car = @cars.findWhere status: 'ready'
      unless car then return @errorProvider 'В данный момент нет свободных машин'

      @selectedOrder.set 'selected', false if @selectedOrder
      @selectedCar.set 'selected', false if @selectedCar

      order.save
        selected: false
        status: 'assigned'
        carId: car.get '_id'

      car.save
        selected: false
        status: 'buisy'
        orderId: order.get '_id'


    initApplyOrderEvents: ->
      @listenTo @orders, 'apply-me', (order) =>
        unless order.get('status') is 'ready' then return @errorProvider 'Заказ должен быть свободным (зеленым)'
        @applyOrderToTopCar order

      @listenTo @orders, 'change:selected', (order) =>
        @selectedOrder.set 'selected', false if @selectedOrder
        @selectedOrder = order

      @listenTo @cars, 'change:selected', (car) =>
        @selectedCar.set 'selected', false if @selectedCar
        @selectedCar = car

  AdminLayout
