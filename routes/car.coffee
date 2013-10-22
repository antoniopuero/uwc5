carService = require "#{global.path.root}/services/carService"

module.exports = (app) ->

    carData =
        point: [30,31]
        carTitle: 'Chevrolet evolution'

    app.get "#{global.apiUrl}/cars", (req, res, next) ->
        carService.getAll (err, cars) ->
            if err then return next(err)
            res.apiResponse cars

    app.post "#{global.apiUrl}/car", (req, res, next) ->
        carService.create carData, (err, car) ->
            if err then return next err
            res.apiResponse car

    app.put "#{global.apiUrl}/cars/:carId", (req, res, next) ->
        carService.get req.params.id, (err, car) ->
            if err then return next err
            unless car? then return next new Error 'sorry,the model is not found'
            res.apiResponse car

    app.delete "#{global.apiUrl}/cars/:carId", (req, res, next) ->
        carService.delete req.params.id, (err, car) ->
            if err then return next err
            unless car? then return next new Error 'sorry,the model is not found'
            res.apiResponse car
