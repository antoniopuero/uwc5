module.exports = (app) ->

    app.get '/', (req, res, next) ->
        console.log req.header 'user-agent'
        if req.user?.isAdmin
            res.render 'admin.html'
        else
            res.render 'user.html'
