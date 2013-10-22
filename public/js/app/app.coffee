define 'app', [
  'cs!cars',
  'cs!orders',
  'cs!adminLayout',
  'cs!/js/app/views/OrderListView',
  'cs!/js/app/views/CreateOrderView'
], (Cars, Orders, AdminLayout, OrderListView, CreateOrderView) ->
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    if $('#admin').length
      App.layout = new AdminLayout
      App.content.show App.layout

  App.addInitializer ->
    Backbone.history.start()

  App