
module.exports = (robot) ->
  robot.respond /xkcd(\s+latest)$/i, (msg) ->
    msg.http("http://xkcd.com/info.0.json")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'The bot thinks there is no latest comic. It\'s broken.'
        else
          object = JSON.parse(body)
          msg.send object.title, object.img, object.alt

  robot.respond /xkcd\s+(\d+)/i, (msg) ->
    num = "#{msg.match[1]}"

    msg.http("http://xkcd.com/#{num}/info.0.json")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Comic #{num} not found.'
        else
          object = JSON.parse(body)
          msg.send object.title, object.img, object.alt

  robot.respond /xkcd/i, (msg) ->
    msg.http("http://xkcd.com/info.0.json")
          .get() (err,res,body) ->
            if res.statusCode == 404
               max = 0
            else
               max = JSON.parse(body).num 
               num = Math.floor((Math.random()*max)+1)
               msg.http("http://xkcd.com/#{num}/info.0.json")
               .get() (err, res, body) ->
                 object = JSON.parse(body)
                 msg.send object.title, object.img, object.alt
