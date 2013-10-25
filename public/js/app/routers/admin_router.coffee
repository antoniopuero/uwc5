define 'adminRouter', ['cs!adminLayout', 'marionette'], (AdminLayout, Marionette) ->
  class AdminRouter extends Marionette.AppRouter
    routes:
      '': 'index'

    index: ->
      App.content.show new AdminLayout

  AdminRouter