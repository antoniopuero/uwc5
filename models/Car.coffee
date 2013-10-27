mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
passwordHash = require 'password-hash'

CarSchema = new Schema
    point:
        type: [Number]

    carTitle:
        type: String

    status:
        type: String
        required: true
        default: 'ready' # || buisy || off

    driverName:
        type: String
        required: true
        default: 'car driver ruben'

    orderId:
        type: ObjectId

    password:
        type: String
        required: true

CarSchema.pre 'save', (next) ->
    if !@isModified('password') then return next()

    hash = passwordHash.generate @password

    @password = hash

    next()

CarSchema.methods.comparePasswords = (candidatePassword, callback) ->
    callback null, passwordHash.verify candidatePassword, @password

module.exports = global.connections.common.model 'Car', CarSchema