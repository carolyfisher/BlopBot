
swear = /bitch|cunt|dick|shit|fuck|asshole| ass |pussy|retard|twat|slut|cock|motherfucker/

module.exports = (robot) ->
  robot.respond swear,(res) ->
    match = res.match[0]
    if Math.random() < 0.3
      res.send "WATCH YOUR LANGUAGE YOU " + match.toUpperCase()
    else
      if Math.random() < 0.35
        res.send "Please watch your language. I'm triggered. I am so offended. That is racist, sexist, ableist, AND transphobic you little cishet shit! I'm going to call the Tumblr police on you! As a agendered communist mayonnaise-kin misandrist, I have -1,269 privilege points, therefore my opinion is fact. Now I am off to my safe space since I have self-diagnosed PTSD, anxiety, autisim, schizophrenia, and OCD."
      else
        res.send "YOU'RE A " + match.toUpperCase()
