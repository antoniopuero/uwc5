userService = require "#{global.path.root}/services/userService"

class AuthError extends Error
    constructor: (message) ->
        @message = message
        super()

class authService
    Errors:
        USER_EXISTS: new AuthError("User with this email already exists")
        USER_NOT_EXISTS: new AuthError("Wrong email")
        WRONG_PASSWORD: new AuthError("Wrong password")

    login: (username, password, callback) ->
        userService.getUserByUsername username, (err, user) =>
            if err then return callback err
            if not user then return callback @Errors.USER_NOT_EXISTS

            user.comparePasswords password, (err, isMatch) =>
                if err then return callback @Errors.WRONG_PASSWORD
                if isMatch then return callback null, user
                return callback @Errors.WRONG_PASSWORD

    register: (data, callback) ->
        userService.getUserByUsername data.username, (err, user) =>
            if err then return callback err
            if user then return callback @Errors.USER_EXISTS

            userService.createUser data, (err, user) =>
                if err then return callback err
                return callback null, user

module.exports = new authService
module.exports.AuthError = AuthError