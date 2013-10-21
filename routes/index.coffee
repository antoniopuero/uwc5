module.exports = (app) ->

    User = require "#{global.path.root}/models/User"
    authService = require "#{global.path.root}/services/authService"

    processAuthResult = (user, req, res, next, err)->
        if err
            if err instanceof authService.AuthError
                errorText = err.message
            else
                errorText = "Unexpected error."
            return res.apiResponse(null, 401, errorText)
        else
            if user
                req.session.userId = user.id.toString()
                res.apiResponse user.toJSON()
            else
                res.apiResponse("ok")

    app.get '/', (req, res, next) ->
        res.render 'index.html'

    app.get '/dispetcher', (req, res, next) ->
      res.render 'dispetcher.html'

    app.post '/user', (req, res, next) ->
        username = req.body.username
        password = req.body.password

        unless username or password
            next new authService.authError 'Wrong username or password'

        authService.register req.body, (err, user) ->
            return processAuthResult user, req, res, next, err

    app.post '/session', (req, res, next) ->
        username = req.body.username
        password = req.body.password

        unless username or password
            next new authService.authError 'Wrong username or password'

        authService.login username, password, (err, user) ->
            return processAuthResult user, req, res, next, err

    app.post '/logout', (req, res, next)->
        req.session.userId = null
        res.apiResponse("ok")
