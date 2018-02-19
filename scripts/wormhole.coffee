# Description:
#   Script to inhale the message on any channels and
#   exhale it to a specific channel in another Workspace
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  user = process.env.HUBOT_AMQP_USER
  pass = process.env.HUBOT_AMQP_PASSWORD
  url  = process.env.HUBOT_AMQP_URL
  isIn  = process.env.HUBOT_WORMHOLE_IN
  isOut = process.env.HUBOT_WORMHOLE_OUT

  if isIn == 'yes'
    robot.hear /(.*)/i, (res) ->
      amqp = require('amqplib')
      amqp.connect("amqp://#{user}:#{pass}@#{url}")
        .then((conn) ->
          conn.createChannel().then((ch) ->
            ex = 'topic.wormhole'
            msg = res.match[1]
            username = res.message.user.name
            key = process.env.HUBOT_WORMHOLE_ROUTING_KEY

            ch.assertExchange(ex, 'topic', {durable: false})
            ch.publish(ex, key, Buffer.from("#{username}「#{msg}」"))
          )
        ).catch((reason) ->
          res.send("Error: #{reason}")
        )

  if isOut == 'yes'
    amqp_cb = require('amqplib/callback_api')
    amqp_cb.connect("amqp://#{user}:#{pass}@#{url}", (err, conn) ->
      room = process.env.HUBOT_EXHALE_ROOM || "wormhole"
      send = (msg) -> robot.messageRoom room, msg
      if err
        send "Error: #{err}"
      else
        conn.createChannel((err, ch) ->
          if err
            send "createChannnel Error: #{err}"
          else
            ex = 'topic.wormhole'
            ch.assertExchange(ex, 'topic', {durable: false})
            ch.assertQueue('', {exclusive: true, durable: false}, (err, q) ->
              if err
                send "Error: #{err}"
              else
                keys = process.env.HUBOT_WORMHOLE_BINDING_KEYS
                for key in keys.split(',')
                  ch.bindQueue(q.queue, ex, key)

                ch.consume(q.queue, (msg) ->
                  send(msg.content.toString())
                  ch.ack(msg)
                )
            )
        )
    )
