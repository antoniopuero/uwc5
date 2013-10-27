orderService = require "#{global.path.root}/services/orderService"
carService = require "#{global.path.root}/services/carService"
_ = require 'underscore'

module.exports = (app) ->
    app.get "#{global.apiUrl}/orders", (req, res, next) ->
        orderService.getAll (err, orders) ->
            if err then return next(err)

            res.apiResponse orders

    app.post "#{global.apiUrl}/orders", (req, res, next) ->
        req.body.userId = req.user?._id unless req.user?.isAdmin
        orderService.create req.body, (err, order) ->
            if err then return next err
            res.apiResponse order, false, false, io: 'order-create'

    app.put "#{global.apiUrl}/orders/:orderId", (req, res, next) ->
        orderService.update req.body, (err, order) ->
            if err then return next err
            order.set req.body
            order.save (err, order) ->
                if err then return next err
                res.apiResponse order, false, false, io: 'order-update'

    app.delete "#{global.apiUrl}/orders/:orderId", (req, res, next) ->
        orderService.remove req.params.orderId, (err, order) ->
            if err then return next err
            unless order? then return next new Error 'sorry,the model is not found'
            res.apiResponse order, false, false, io: 'order-delete'

    app.get "#{global.apiUrl}/myorders", (req, res, next) ->
        next new app.Errors.Unauthorized() unless req.user
        orderService.getUserOrders req.user._id, (err, orders) ->
            if err then return next err

            res.apiResponse orders
