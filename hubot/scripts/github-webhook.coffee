builder = require '../utils/github-webhook.js'

module.exports = (robot) ->
  chat = robot.adapter.client.web.chat
  robot.router.post "/github-webhook", (req, res) ->
    req.params =  if req.body.payload? then JSON.parse req.body.payload else req.body
    builder req, (err, _res, data) ->
      msg = data.message
      msg.channel = "#코드리뷰"
      msg.as_user = true
      chat.makeAPICall 'chat.postMessage', msg
      res.send 'OK'

  robot.router.post '/hubot/chatsecrets', (req, res) ->
    req.params =  if req.body.payload? then JSON.parse req.body.payload else req.body
    builder req, (err, _res, data) ->
      msg = data.message
      msg.channel = "#voo테스트"
      msg.as_user = true
      chat.makeAPICall 'chat.postMessage', msg
      res.send 'OK'

  robot.router.post '/hubot/lwiefwli/talk', (req, res) ->
    req.params =  if req.body.payload? then JSON.parse req.body.payload else req.body
    msg =
      text: req.params.text
      channel: req.params.channel
      as_user: true
    chat.makeAPICall 'chat.postMessage', msg
    res.send 'OK'
