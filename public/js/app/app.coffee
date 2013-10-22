define 'app', [
    'cs!cars',
    'cs!orders',
    'cs!/js/app/views/OrderListView',
    'cs!/js/app/views/CreateOrderView'
    ], (Cars, Orders, OrderListView, CreateOrderView) ->

    App = new Marionette.Application()

    App.addRegions
        nav: "#nav"
        content: "#content"
        orders: "#orders"
        cars: "#cars"

    App.addInitializer ->
        Backbone.history.start()

    cars = new Cars
    orders = new Orders
    orderListView = new OrderListView collection: orders

    orders.on 'reset', () ->
        App.orders.show orderListView

    cars.fetch reset: true
    orders.fetch reset: true

    createOrderView = new CreateOrderView
        el: "#admin-form"
        collection: orders

    App