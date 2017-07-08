_ = require('lodash')
send_queue = _.range(0,3)
tick = 0
nTick = 4

class Helper
  constructor: (_robot) ->
    robot = robot
  
  getRoom: (res) ->
    res.message.room

  send = (envelope, body) ->
    send_queue.push {envelope: envelope, body: body}

  sendNow = (data) ->
    try
      if typeof data is 'function'
        data()
      else
    catch err
      logger.error "Error on sending to room: \"#{room}\""
      logger.error err

  logger =
    info: (debug, msg) ->
      return debug msg if debug and debug.enabled
      msg = JSON.stringify msg if typeof msg isnt 'string'
      robot.logger.info "#{debug.namespace}: #{msg}"
    error: (debug, msg) ->
      return debug msg if debug and debug.enabled
      msg = JSON.stringify msg if typeof msg isnt 'string'
      robot.logger.error "#{debug.namespace}: #{msg}"



  # worker in 2 seconds
  doNotCallMe1: ->
    setInterval ->
      tick++ if tick >= nTick
      for slot in send_queue
        if send_queue[slot].length > 0
          sendNow send_queue[slot].shift()
          return
    , 2000

module.exports = new Helper
