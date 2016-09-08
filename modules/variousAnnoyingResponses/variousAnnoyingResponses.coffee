laughs = [
  "AHAHAHAHA THAT'S FUNNY",
  "LOLOLOOLLOLOLOLOLLOLOLOLOL",
  "I'm laughing out loud!",
  "Is there something funny, or are you inaccurately laughing?"
]

thanks = [
  "You're welcome m'lady",
  "Yeah, you better be thankful",
  "No promblemo"
]

weed = [
  "Drugs are bad kids",
  "420 BLAZE IT"
]

module.exports = (robot) ->
  robot.hear /(haha|lol|lmao|lmfao)/i, (res) ->
    res.send res.random laughs

  robot.hear /haramba?e/i, (res) ->
    res.send "DICKS OUT FOR HARAMBE"

  robot.hear /thank/, (res) ->
    res.send res.random thanks

  robot.hear /ayyy*/i, (res) ->
    res.send "lmao" + String.fromCharCode(55357, 56445)

  robot.hear /weed|smoke|cigarette|vape|pot |420/i, (res) ->
    res.send res.random weed