define [
  'cs!navView'
  'cs!adminRouter'
  'cs!userRouter'
], (NavView, AdminRouter, UserRouter) ->
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    if $('#admin').length
      App.router = new AdminRouter

    if $('#user').length
      App.router = new UserRouter

    App.nav.show new NavView

  App.addInitializer ->
    Backbone.history.start()

  App.socket = io.connect('http://localhost:3000')

  window.App = App

  App