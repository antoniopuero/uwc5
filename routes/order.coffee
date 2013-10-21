orderService = require "#{global.path.root}/services/orderService"

module.exports = (app) ->
    orderData =
        startPoint: [30,31]
        endPoint: [30,32]
        startPointTitle: 'Goloseeve'
        endPointTitle:  'Maidan'

    app.get "#{global.apiUrl}/orders", (req, res, next) ->
        orderService.getAll (err, orders) ->
            if err then return next(err)
            res.apiResponse orders
        res.apiResponse

    app.get "#{global.apiUrl}/order", (req, res, next) ->
        orderService.create orderData, (err, order) ->
            console.log arguments
            res.apiResponse order

