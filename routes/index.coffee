module.exports = (app) ->
    #User = require "#{global.path.root}/models/User"

    app.get '/', (req, res, next) ->
        # next('blaaa');
        res.render 'index.html'

    app.post '/sign-up', (req, res, next) ->
        user = new User req.body
        user.save (err, user) ->
            if err then return next(err)
            console.log user