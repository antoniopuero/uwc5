mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

CarSchema = new Schema
    point:
        type: [Number]
        required: true

    carTitle:
        type: String
        required: true

    status:
        type: String
        required: true
        default: 'ready' # || buisy || off

    driverName:
        type: String
        required: true
        default: 'ashot'

module.exports = global.connections.common.model 'Car', CarSchema