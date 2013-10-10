User = require "#{global.path.root}/models/User"

module.exports = (app) ->
    app.get '/', (req, res, next) ->
        console.log 'bla'
        res.render 'index.html'

    app.post '/user', (req, res, next) ->
        user = new User req.body
        user.save (err, user) ->
            if err then return next(err)
            console.log user