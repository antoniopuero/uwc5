carService = require "#{global.path.root}/services/carService"

class AuthError extends Error
    constructor: (message) ->
        @message = message
        @code = 400
        super()

class carAuthService
    Errors:
        CAR_EXIST: new AuthError("Пользователь с таким email уже существует")
        CAR_NOT_EXIST: new AuthError("Неверный email")
        WRONG_PASSWORD: new AuthError("Неверный пароль")

    login: (driverName, password, callback) ->
        carService.getByDriverName driverName, (err, car) =>
            if err then return callback err
            if not car then return callback @Errors.CAR_NOT_EXIST

            car.comparePasswords password, (err, isMatch) =>
                if err then return callback @Errors.WRONG_PASSWORD
                if isMatch then return callback null, car
                return callback @Errors.WRONG_PASSWORD

    regOrLogin: (data, callback) ->
        carService.getByDriverName data.driverName, (err, car) =>
            if err then return callback err

            if car
                @login data.driverName, data.password, callback
            else
                @register data, (err, car) ->
                    callback err, car, true

    register: (data, callback) ->
        carService.getByDriverName data.username, (err, driver) =>
            if err then return callback err
            if driver then return callback @Errors.CAR_EXIST

            carService.create data, (err, driver) =>
                if err then return callback err
                return callback null, driver

module.exports = new carAuthService
module.exports.AuthError = AuthError