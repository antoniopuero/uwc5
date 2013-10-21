carService = require "#{global.path.root}/services/carService"

module.exports = (app) ->

    carData =
        point: [30,31]
        carTitle: 'Chevrolet evolution'

    app.get "#{global.apiUrl}/cars", (req, res, next) ->
        carService.getAll (err, cars) ->
            if err then return next(err)
            res.apiResponse cars

        res.apiResponse

    app.get "#{global.apiUrl}/car", (req, res, next) ->
        carService.create carData, (err, car) ->
            console.log arguments
            res.apiResponse car
