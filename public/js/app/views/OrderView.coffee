define ['text!/js/app/templates/order.html'], (orderTemplate) ->
    OrderView = Marionette.ItemView.extend
        tagName: 'tr'
        template: orderTemplate
