
module.exports = (robot) ->
  robot.respond /(img )(.+)/i, (msg) ->
    flag=false
    if msg.match[2].search("gif") != -1
      msg.match[2] = msg.match[2].replace("gif", "")
      flag = true
    imageMe msg, msg.match[2], flag, (url) ->
      msg.send url


imageMe = (msg, query, animated, cb) ->
  cb = animated if typeof animated == 'function'
  googleCseId = process.env.HUBOT_GOOGLE_CSE_ID
  if googleCseId
    googleApiKey = process.env.HUBOT_GOOGLE_CSE_KEY
    if !googleApiKey
      msg.send "API Keys broken."
      return
    q =
      q: query,
      searchType:'image',
      fields:'items(link)',
      cx: googleCseId,
      key: googleApiKey
    if animated is true
      q.fileType = 'gif'
      q.hq = 'animated'
      q.tbs = 'itp:animated'
    url = 'https://www.googleapis.com/customsearch/v1'
    msg.http(url)
    .query(q)
    .get() (err, res, body) ->
      if err
        if res.statusCode is 403
          msg.send "Y'all used the image search too much, I'm not spending money for the API."
        else
          msg.send "Some other error of number;  #{err}"
        return
      if res.statusCode isnt 200
        msg.send "HTTP response has failed."
        return
      response = JSON.parse(body)
      if response?.items
        image = msg.random response.items
        cb ensureResult(image.link, animated)
      else
        msg.send "Your query of '#{query}' is weird. Something went wrong."
        ((error) ->
          msg.robot.logger.error error.message
          msg.robot.logger
          .error "(see #{error.extendedHelp})" if error.extendedHelp
        ) error for error in response.error.errors if response.error?.errors
  else
    msg.send "Something went really fucking wrong. "

# Forces giphy result to use animated version
ensureResult = (url, animated) ->
  if animated is true
    ensureImageExtension url.replace(
      /(giphy\.com\/.*)\/.+_s.gif$/,
      '$1/giphy.gif')
  else
    ensureImageExtension url

# Forces the URL look like an image URL by adding `#.png`
ensureImageExtension = (url) ->
  if /(png|jpe?g|gif)$/i.test(url)
    url
  else
    "#{url}#.png"