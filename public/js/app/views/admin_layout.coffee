define 'adminLayout', [
  'cs!cars'
  'cs!orders'
  'cs!order'
  'cs!car'
  'cs!carMapView'
  'cs!carListView'
  'cs!orderListView'
  'cs!createOrderView'
  'marionette'
], (Cars, Orders, Order, Car, CarMapView, CarListView, OrderListView, CreateOrderView) ->
  class AdminLayout extends Marionette.Layout
    template: '#admin-template'

    initialize: ->
      @cars = new Cars
      @orders = new Orders


      @initApplyOrderEvents()

      App.socket.on 'order-create', (data) =>
        @orders.add new Order(data)

      App.socket.on 'order-update', (data) =>
        @orders.add new Order(data), merge: true

      App.socket.on 'order-delete', (data) =>
        @orders.remove new Order(data)

      App.socket.on 'car-create', (data) =>
        @cars.add new Car(data)

      App.socket.on 'car-update', (data) =>
        @cars.add new Car(data), merge: true

      App.socket.on 'car-delete', (data) =>
        @cars.remove new Car(data)

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
      if App.map.line and @selectedOrder.get('status') is 'ready'
        App.map.line.setEditable(true)
      else
        @errorProvider 'Выберите свободный заказ'

    errorProvider: (error) ->
      alert error

    applyOrder: ->
      unless @selectedOrder? then return @errorProvider 'Выберите заказ, пожалуйста'
      unless @selectedCar? then return @errorProvider 'Выберите машину, пожалуйста'
      unless (@selectedOrder.get('status') is 'ready') then return @errorProvider 'Заказ должен быть свободным (зеленым)'
      unless (@selectedCar.get('status') is 'ready') then return @errorProvider 'Таксист должен быть онлайн и свободным (зеленым)'

      @selectedOrder.set 'selected', false if @selectedOrder
      @selectedCar.set 'selected', false if @selectedCar

      @selectedOrder.save
        selected: false
        status: 'assigned'
        carId: @selectedCar.get '_id'

      @selectedCar.save
        selected: false
        status: 'busy'
        orderId: @selectedOrder.get '_id'

      @selectedOrder = false
      @selectedCar = false


    applyOrderToTopCar: (order) ->
      car = @cars.findWhere status: 'ready'
      unless car then return @errorProvider 'В данный момент нет свободных машин'

      @selectedOrder.set 'selected', false if @selectedOrder
      @selectedCar.set 'selected', false if @selectedCar

      @selectedOrder = false
      @selectedCar = false

      order.save
        selected: false
        status: 'assigned'
        carId: car.get '_id'

      car.save
        selected: false
        status: 'busy'
        orderId: order.get '_id'


    renderCarOrder: (car) ->
      order = @orders.get car.get('orderId')
      OrderListView.drawOrderPath(order) if order?

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
        @renderCarOrder(car)

  AdminLayout
