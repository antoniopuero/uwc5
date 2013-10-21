define 'app', ["cs!account", "marionette"], (account) ->
  console.log "init"
  App = new Marionette.Application()

  App.addRegions
    nav: "#nav"
    content: "#content"

  App.addInitializer ->
    Backbone.history.start();

  App