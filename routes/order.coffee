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

    app.post "#{global.apiUrl}/order", (req, res, next) ->
        orderService.create carData, (err, order) ->
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
