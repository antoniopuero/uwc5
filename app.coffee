mongoose = require 'mongoose'

global.path =
    root: require('path').normalize("#{__dirname}")

global.config = (require "#{global.path.root}/config")

global.connections = {
    common: mongoose.createConnection(config.dbUri)
}

express = require 'express'
app = module.exports = express()
fs = require 'fs'
cons = require 'consolidate'

#VIEWS ENGINE

app.engine 'html', cons.swig

#set .html as the default extension
app.set('view engine', 'html')
app.set('views', "#{global.path.root}/views")
app.set('port', process.env.PORT || 3000);


app.use express.bodyParser()
app.use express.static("#{global.path.root}/public")

# Use this error when page is not found
class NotFound extends Error
    constructor: (path) ->
        @.name = 'Not Found'
        @.code = 404
        @.path = path
        Error.call @, path
        Error.captureStackTrace @, arguments.callee

class Forbidden extends Error
    constructor: (path) ->
        @.name = 'Forbidden'
        @.code = 403
        Error.call @, 'Forbidden'
        Error.captureStackTrace @, arguments.callee

class Unauthorized extends Error
    constructor: (path) ->
        @.name = 'Unauthorized'
        @.code = 401
        Error.call @, 'Unauthorized'
        Error.captureStackTrace @, arguments.callee

class BadRequest extends Error
    constructor: (msg) ->
        @.name = msg || 'Bad request'
        @.code = 400
        Error.call @
        Error.captureStackTrace @, arguments.callee

app.Errors = {
    NotFound: NotFound
    Forbidden: Forbidden
    Unauthorized: Unauthorized
    BadRequest: BadRequest
}


initRoutes = (path)->
    files = fs.readdirSync path
    for file in files
        curPath = "#{path}/#{file}"
        if fs.statSync(curPath).isDirectory()
            initRoutes curPath
        else
            (require curPath)(app)

initRoutes "#{global.path.root}/routes"

app.use (err, req, res, next) ->
    if req.xhr
        res.json({code: 500, result: null, error: "Unexptected error"})
    else
        if err instanceof NotFound
            res.status(404)
            res.render 'errors/404.html'
        else if err instanceof Unauthorized or err instanceof Forbidden
            res.status(403)
            res.render 'errors/403.html'
        else
            console.log(err.stack || err)
            res.status(500)
            res.render 'errors/500.html'

app.listen(app.get('port'))
console.log 'Listening on port ' + app.get 'port'
