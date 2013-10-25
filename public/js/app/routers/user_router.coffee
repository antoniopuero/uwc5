define 'userRouter', ['cs!userLayout', 'cs!userOrdersLayout', 'marionette'], (UserLayout, UserOrdersLayout, Marionette) ->
  class UserRouter extends Marionette.AppRouter
    routes:
      '': 'index'
      'orders': 'orders'

    index: ->
      App.content.show new UserLayout

    orders: ->
      App.content.show new UserOrdersLayout

  UserRouter