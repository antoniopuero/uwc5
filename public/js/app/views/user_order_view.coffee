define 'userOrderView', ['marionette', 'cs!orderView'], (Marionette, OrderView) ->
  class UserOrderView extends OrderView
    template: '#user-order-template'

  UserOrderView