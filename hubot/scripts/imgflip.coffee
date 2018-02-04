# Description:
#   Generates memes via the Imgflip Meme Generator API
#
# Dependencies:
#   None
#
# Configuration:
#   IMGFLIP_API_USERNAME [optional, overrides default imgflip_hubot account]
#   IMGFLIP_API_PASSWORD [optional, overrides default imgflip_hubot account]
#
# Commands:
#   hubot meme dg <text>~<text> - Disaster Girl
#   hubot meme One does not simply <text> - Lord of the Rings Boromir
#   hubot meme I don't always <text> but when i do <text> - The Most Interesting man in the World
#   hubot meme aliens <text> - Ancient Aliens History Channel Guy
#   hubot meme grumpy cat <text> - Grumpy Cat with text on the bottom
#   hubot meme <text>, <text> everywhere - X, X Everywhere (Buzz and Woody from Toy Story)
#   hubot meme Not sure if <text> or <text> - Futurama Fry
#   hubot meme Y U NO <text> - Y U NO Guy
#   hubot meme Brace yourselves <text> - Brace Yourselves X is Coming (Imminent Ned, Game of Thrones)
#   hubot meme <text> all the <text> - X all the Y
#   hubot meme <text> that would be great - Bill Lumbergh from Office Space
#   hubot meme <text> too damn <text> - The rent is too damn high
#   hubot meme Yo dawg <text> so <text> - Yo Dawg Heard You (Xzibit)
#   hubot meme <text> you're gonna have a bad time - Super Cool Ski Instructor from South Park
#   hubot meme Am I the only one around here <text> - The Big Lebowski
#   hubot meme What if I told you <text> - Matrix Morpheus
#   hubot meme <text> ain't nobody got time for that
#   hubot meme <text> I guarantee it - George Zimmer
#   hubot meme <text> and it's gone - South Park Banker Guy
#   hubot meme <text> nobody bats an eye <text> everyone loses their minds - Heath Ledger Joker
#   hubot meme back in my day <text> - Grumpy old man
#
# Author:
#   dylanwenzlau
#
# Contributors:
#   spkane
#


inspect = require('util').inspect

module.exports = (robot) ->
  unless robot.brain.data.imgflip_memes?
    robot.brain.data.imgflip_memes = [
      {
        regex: /meme (one does not simply) (.*)/i,
        template_id: 61579
      },
      {
        regex: /meme dg (.*)~((.*)|)/i,
        template_id: 97984
      },
      {
        regex: /meme (i don'?t always .*) (but when i do,? .*)/i,
        template_id: 61532
      },
      {
        regex: /meme aliens ()(.*)/i,
        template_id: 101470
      },
      {
        regex: /meme grumpy cat ()(.*)/i,
        template_id: 405658
      },
      {
        regex: /meme (.*),? (\1 everywhere)/i,
        template_id: 347390
      },
      {
        regex: /meme (not sure if .*) (or .*)/i,
        template_id: 61520
      },
      {
        regex: /meme (y u no) (.+)/i,
        template_id: 61527
      },
      {
        regex: /meme (brace yoursel[^\s]+) (.*)/i,
        template_id: 61546
      },
      {
        regex: /meme (.*) (all the .*)/i,
        template_id: 61533
      },
      {
        regex: /meme (.*) (that would be great|that'?d be great)/i,
        template_id: 563423
      },
      {
        regex: /meme (.*) (\w+\stoo damn .*)/i,
        template_id: 61580
      },
      {
        regex: /meme (yo dawg .*) (so .*)/i,
        template_id: 101716
      },
      {
        regex: /meme (.*) (.* gonna have a bad time)/i,
        template_id: 100951
      },
      {
        regex: /meme (am i the only one around here) (.*)/i,
        template_id: 259680
      },
      {
        regex: /meme (what if i told you) (.*)/i,
        template_id: 100947
      },
      {
        regex: /meme (.*) (ain'?t nobody got time for? that)/i,
        template_id: 442575
      },
      {
        regex: /meme (.*) (i guarantee it)/i,
        template_id: 10672255
      },
      {
        regex: /meme (.*) (a+n+d+ it'?s gone)/i,
        template_id: 766986
      },
      {
        regex: /meme (.* bats an eye) (.* loses their minds?)/i,
        template_id: 1790995
      },
      {
        regex: /meme (back in my day) (.*)/i,
        template_id: 718432
      }
    ]

  for meme in robot.brain.data.imgflip_memes
    setupResponder robot, meme

setupResponder = (robot, meme) ->
  robot.respond meme.regex, (msg) ->
    generateMeme msg, meme.template_id, msg.match[1], msg.match[2]

generateMeme = (msg, template_id, text0, text1) ->
  username = process.env.IMGFLIP_API_USERNAME
  password = process.env.IMGFLIP_API_PASSWORD

  if (username or password) and not (username and password)
    msg.reply 'To use your own Imgflip account, you need to specify username and password!'
    return

  if not username
    username = 'imgflip_hubot'
    password = 'imgflip_hubot'

  msg.http('https://api.imgflip.com/caption_image')
  .query
      template_id: template_id,
      username: username,
      password: password,
      text0: text0,
      text1: text1
  .post() (error, res, body) ->
    if error
      msg.reply "I got an error when talking to imgflip:", inspect(error)
      return

    result = JSON.parse(body)
    success = result.success
    errorMessage = result.error_message

    if not success
      msg.reply "Imgflip API request failed: #{errorMessage}"
      return

    msg.send result.data.url

