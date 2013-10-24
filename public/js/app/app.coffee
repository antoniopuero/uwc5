define ['cs!adminLayout', 'cs!userLayout'], (AdminLayout, UserLayout) ->
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    if $('#admin').length
      App.layout = new AdminLayout

    if $('#user').length
      App.layout = new UserLayout

    App.content.show App.layout

  App.addInitializer ->
    Backbone.history.start()

  App.socket = io.connect('http://localhost:3000')

  window.App = App

  App