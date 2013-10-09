module.exports = (app) ->
    app.get '/', (req, res, next) ->
        console.log 'bla'
        res.render 'index.html'

    app.post '/sign-up', (req, res, next) ->
        user = new User req.body
        user.save (err, user) ->
            if err then return next(err)
            console.log user