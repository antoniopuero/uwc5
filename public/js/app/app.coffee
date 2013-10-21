define 'app', ['cs!cars', 'cs!orders', "cs!account", "marionette", ], (Cars, Orders) ->
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    Backbone.history.start()

  cars = new Cars
  cars.fetch()

  orders = new Orders
  orders.fetch()

  console.log cars
  console.log orders

  App