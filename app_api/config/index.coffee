module.exports = (app) ->
  app.config = require('./config.coffee')(app).config
