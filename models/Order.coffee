Car = require "#{global.path.root}/models/Car"
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

OrderSchema = new Schema
    startPoint:
        type: [Number]
        required: true

    endPoint:
        type: [Number]
        required: true

    startPointTitle:
        type: String
        required: true

    endPointTitle:
        type: String
        required: true

    path:
        type: {}

    distance:
        type: Number

    phone:
        type: String

    status:
        type: String
        required: true
        default: 'ready' # || assigned || completed

    price:
        type: String
        required: true

    date:
        type: String
        required: true
        default: 'now'

    userId:
        type: String

    carId:
        type: String

OrderSchema.methods.getCarsNearby = (callback) ->
    Car.near(@startPoint).exec callback

OrderSchema.methods.assignCar = (car, callback) ->
        @carId = car.id
        @status = 'assigned'
        @save callback

OrderSchema.methods.ready = (callback) ->
        @status = 'ready'
        @carId = null
        @save callback

OrderSchema.methods.complete = (callback) ->
        @status = 'completed'
        @save callback

module.exports = global.connections.common.model 'Order', OrderSchema