Car = require "#{global.path.root}/models/Car"

class CarService
    create: (data, callback) ->
        user = new Car data
        user.save callback

    get: (id, callback)->
        Car.findById(id, callback)

    getAll: (callback) ->
        Car.find {}, callback

    remove: (id, callback) ->
        Car.remove { _id: id } , callback

module.exports = new CarService