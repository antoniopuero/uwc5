Order = require "#{global.path.root}/models/Order"

class OrderService
    create: (data, callback) ->
        user = new Order data
        user.save callback

    get: (id, callback)->
        Order.findById(id, callback)

    getAll: (callback) ->
        Order.find {}, callback

    remove: (id, callback) ->
        Order.remove { id: id } , callback

module.exports = new OrderService