module.exports = (app) ->

    app.get '/', (req, res, next) ->
        if req.user?.isAdmin
            res.render 'admin.html'
        else
            res.render 'user.html'

    app.get '/admin', (req, res, next) ->
      res.render 'admin.html'

    app.get '/mobile', (req, res, next) ->
      res.render 'mobile.html'
