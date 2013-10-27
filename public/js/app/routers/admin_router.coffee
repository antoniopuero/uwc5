define ['cs!app/views/admin_layout', 'marionette'], (AdminLayout, Marionette) ->
  class AdminRouter extends Marionette.AppRouter
    routes:
      '': 'index'

    index: ->
      App.layout = new AdminLayout
      App.content.show App.layout

  AdminRouter