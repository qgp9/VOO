module.exports = (robot) ->
  robot.respond /help(\s+(\S+))?/i, (res) ->
    username = res.message.user.name
    room = res.message.room

    robot.messageRoom room, "@#{username}" 


