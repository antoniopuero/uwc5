define 'userRouter', ['cs!userLayout', 'cs!userOrdersLayout', 'marionette'], (UserLayout, UserOrdersLayout, Marionette) ->
  class UserRouter extends Marionette.AppRouter
    routes:
      '': 'index'
      'orders': 'orders'

    index: ->
      App.layout = new UserLayout
      App.content.show App.layout

    orders: ->
      App.layout = new UserOrdersLayout
      App.content.show App.layout

  UserRouter