mongoose = require 'mongoose'
passwordHash = require 'password-hash'
Schema = mongoose.Schema
SALT_WORK_FACTOR = 10

UserSchema = new Schema
    username:
        type: String
        required: true
        index:
            unique: true
    password:
        type: String
        required: true

UserSchema.pre 'save', (next) ->
    if !@isModified('password') then return next()

    hash = passwordHash.generate @password

    @password = hash

    next()

UserSchema.methods.comparePasswords = (candidatePassword, callback) ->
    console.log passwordHash.verify candidatePassword, @password
    callback null, passwordHash.verify candidatePassword, @password

module.exports = global.connections.common.model 'User', UserSchema
