define ['cs!adminLayout'], (AdminLayout) ->
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

  App.socket = io.connect('http://localhost:3000')

  window.App = App

  App