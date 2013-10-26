define 'userOrderView', ['marionette', 'cs!orderView'], (Marionette, OrderView) ->
  class UserOrderView extends OrderView
    attributes: {}

    template: '#user-order-template'

  UserOrderView