define ['cs!userOrderView', 'cs!orderListView'], (UserOrderView, OrderListView) ->
  class UserOrdersView extends OrderListView
    itemView: UserOrderView

  UserOrdersView