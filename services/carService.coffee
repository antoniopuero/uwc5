Car = require "#{global.path.root}/models/Car"

class CarService
    create: (data, callback) ->
        user = new Car data
        user.save callback

    get: (id, callback)->
        Car.findById(id, callback)

    getByDriverName: (driverName, callback) ->
        Car.find {driverName: driverName}, (err, cars) ->
            if err then return callback err
            callback null, cars[0]

    getAll: (callback) ->
        Car.find {}, callback

    update: (data, callback) ->
        Car.findById data._id, (err, car) ->
            if err then return callback err
            unless car? then return callback new Error 'sorry,the model is not found'
            car.set data
            car.save callback

    remove: (id, callback) ->
        Car.findById id , (err, car) ->
            if err then return callback err
            unless car? then return callback new Error 'Sorry, car is not found'

            car.remove (err) ->
                if err then return callback err
                callback null, car

module.exports = new CarService