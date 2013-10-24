Order = require "#{global.path.root}/models/Order"

class OrderService
    create: (data, callback) ->
        user = new Order data
        user.save callback

    get: (id, callback)->
        Order.findById(id, callback)

    getAll: (callback) ->
        Order.find {}, callback

    update: (data, callback) ->
        Order.findById data._id, (err, order) ->
            if err then return callback err
            unless order? then return callback new Error 'sorry,the model is not found'
            order.set data
            order.save callback

    remove: (id, callback) ->
        Order.findById id , (err, order) ->
            if err then return callback err
            unless order? then return callback new Error 'Sorry, order is not found'

            order.remove (err) ->
                if err then return callback err
                callback null, order

module.exports = new OrderService