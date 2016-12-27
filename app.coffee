express = require('express')
path = require('path')
logger = require('morgan')
expressJwt = require('express-jwt')
jwt = require('jsonwebtoken')
exp_unless = require('express-unless')
expressBusboy = require('express-busboy')

app = express()

app.extra =
    _: require('lodash')

config = require('./app_api/config/index.coffee')(app)

require('./app_api/db/index.coffee')(app)

extendedApp =
    upload: true
    path: path.join __dirname, 'uploads/'
    allowedPath: path.join __dirname, 'uploads/'
    mimeTypeLimit: [
        'image/jpeg'
        'image/png'
    ]

expressBusboy.extend app, extendedApp

app.use('/static', express.static path.join(__dirname, 'uploads/'))

app.use(logger('dev'))

testFun = (req, res) ->
    ob =
        message:'ok'
        test: 'fine'
    res.json ob

app.use '/api', testFun

module.exports = app