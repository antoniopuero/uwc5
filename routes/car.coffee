carService = require "#{global.path.root}/services/carService"

module.exports = (app) ->
    app.get "#{global.apiUrl}/cars", (req, res, next) ->
        carService.getAll (err, cars) ->
            if err then return next(err)
            res.apiResponse cars

    app.post "#{global.apiUrl}/car", (req, res, next) ->
        carService.create carData, (err, car) ->
            if err then return next err
            res.apiResponse car, false, false, io: 'car-create'

    app.put "#{global.apiUrl}/cars/:carId", (req, res, next) ->
        carService.update req.body, (err, car) ->
            if err then return next err
            car.set req.body
            car.save (err, car) ->
                if err then return next err
                res.apiResponse car, false, false, io: 'car-update'

    app.delete "#{global.apiUrl}/cars/:carId", (req, res, next) ->
        carService.delete req.params.id, (err, car) ->
            if err then return next err
            unless car? then return next new Error 'sorry,the model is not found'
            res.apiResponse car, false, false, io: 'car-create'
