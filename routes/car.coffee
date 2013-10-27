carService = require "#{global.path.root}/services/carService"
carAuthService = require "#{global.path.root}/services/carAuthService"

processAuthResult = (car, req, res, next, err, isNew)->
    if err
        if err instanceof carAuthService.AuthError
            errorText = err.message
        else
            errorText = "Unexpected error."
        return res.apiResponse(null, 401, errorText)
    else
        if car
            req.session.carId = car.id.toString()
            if isNew
                res.apiResponse car.toJSON(), false, false, io: 'car-create'
            else
                res.apiResponse car.toJSON()
        else
            res.apiResponse("ok")

module.exports = (app) ->

    app.get "#{global.apiUrl}/cars", (req, res, next) ->
        carService.getAll (err, cars) ->
            if err then return next(err)
            res.apiResponse cars

    app.post "#{global.apiUrl}/cars/auth", (req, res, next) ->
        driverName = req.body.driverName
        password = req.body.password

        unless driverName and password
            next new carAuthService.AuthError 'Wrong driverName or password'

        carAuthService.regOrLogin req.body, (err, car, isNew) ->
            return processAuthResult car, req, res, next, err, isNew

    app.post "#{global.apiUrl}/cars", (req, res, next) ->
        carService.create req.body, (err, car) ->
            if err then return next err
            res.apiResponse car, false, false, io: 'car-create'

    app.post "#{global.apiUrl}/car/session", (req, res, next) ->
        driverName = req.body.driverName
        password = req.body.password

        unless driverName or password
            next new carAuthService.authError 'Wrong driverName or password'

        carAuthService.login driverName, password, (err, car) ->
            return processAuthResult car, req, res, next, err

    app.post "/#{global.apiUrl}", (req, res, next)->
        req.session.carId = null
        res.apiResponse("ok")

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



