orderService = require "#{global.path.root}/services/orderService"
carService = require "#{global.path.root}/services/carService"

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

    app.post "#{global.apiUrl}/order", (req, res, next) ->
        orderService.create req.body, (err, order) ->
            if err then return next err
            res.apiResponse order

    app.put "#{global.apiUrl}/update/:carId", (req, res, next) ->
        orderService.get req.params.id, (err, order) ->
            if err then return next err
            unless order? then return next new Error 'sorry,the model is not found'
            res.apiResponse order

    app.delete "#{global.apiUrl}/delete/:carId", (req, res, next) ->
        orderService.delete req.params.id, (err, order) ->
            if err then return next err
            unless order? then return next new Error 'sorry,the model is not found'
            res.apiResponse order

    app.get "#{global.apiUrl}/order/:orderId/car/:carId/asign", (req, res, next) ->
        orderService.get req.params.orderId, (err, order) ->
            if err then return next err
            unless order? then return next new Error 'sorry,the order is not found'

            carService.get req.params.carId, (err, car) ->
                if err then return next err
                unless car? then return next new Error 'sorry,the car is not found'
                order.assignCar car, (err, result) ->
                    if err then return next err
                    res.apiResponse result

    app.get "#{global.apiUrl}/order/:orderId/ready", (req, res, next) ->
        orderService.get req.params.orderId, (err, order) ->
            if err then return next err
            unless order? then return next new Error 'sorry,the order is not found'
            order.ready (err, result) ->
                if err then return next err
                res.apiResponse result

    app.get "#{global.apiUrl}/order/:orderId/complete", (req, res, next) ->
        orderService.get req.params.orderId, (err, order) ->
            console.log arguments
            if err then return next err
            unless order? then return next new Error 'sorry,the order is not found'
            order.complete (err, result) ->
                if err then return next err
                res.apiResponse result
