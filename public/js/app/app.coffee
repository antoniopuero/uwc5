define 'app', ["cs!adminLayout", "cs!account", "marionette"], (AdminLayout) ->
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    Backbone.history.start()

  App.addInitializer ->
    App.layout = new AdminLayout
    App.content.show App.layout

  App