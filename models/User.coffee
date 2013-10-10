mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
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

    bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) =>
        if err then return next(err)

        bcrypt.hash @password, salt, (err, hash) =>
            if err then return next(err)

            @password = hash
            next()

UserSchema.methods.comparePasswords = (candidatePassword, callback) =>
    bcrypt.compare candidatePassword, @password, (err, isMatch) =>
        if err then return callback err
        return callback null, isMatch

module.exports = global.connections.common.model 'User', UserSchema
