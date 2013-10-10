User = require "#{global.path.root}/models/User"

class userService
    constructor: () ->
        return false

    createUser: (data, callback) ->
        user = new User data
        user.save (err, user) =>
            if err then return callback err
            return callback user

    getUserByUsername: (username, callback) ->
        User.findOne { username: username }, (err, user) =>
            if err then return callback err
            return callback user

    removeUserByUsername: (username, callback) ->
        User.remove { username: username} , (err) =>
            if err then return callback err
            return callback null

module.exports = new userService