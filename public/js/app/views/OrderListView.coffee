define ['cs!/js/app/views/OrderView'], (OrderView) ->
    OrderListView = Marionette.CollectionView.extend
        itemView: OrderView
        tagName: 'table'
        className: 'table table-bordered table-striped table-hover'
