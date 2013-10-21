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

    status:
        type: String
        required: true
        default: 'ready'

    time:
        type: String
        required: true
        default: 'now'

    userId:
        type: ObjectId

    carId:
        type: ObjectId


OrderSchema.methods.ready = (callback) ->
    @status = 'ready'
    @save callback

OrderSchema.methods.getCarsNearby = (callback) ->
    Car.near(@startPoint).exec callback

OrderSchema.methods.assignCar = (carId, callback) ->
    Car.get carId, (err, car) ->
        if err then return callback err
        unless car? then return callback(new Error('car with this id is not exists'))
        @carId = car.id
        @save callback

module.exports = global.connections.common.model 'Order', OrderSchema