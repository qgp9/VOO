builder = require '../utils/github-webhook.js'

module.exports = (robot) ->
  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/chatsecrets', (req, res) ->
    # room   = req.params.room
    req.params =  if req.body.payload? then JSON.parse req.body.payload else req.body
    builder req, (err, res, data) ->
      console.log data
      robot.messageRoom "#voo-test", data.message if data.message
    # secret = data.secret
    # console.log req.body

    res.send 'OK'
