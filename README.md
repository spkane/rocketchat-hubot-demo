# rocketchat-hubot example

This is intended to be a demonstration of using Docker Compose to launch a series of semi-complex applications that include a datastore, web UI, and chat bot.

Note that you'll need to create your admin user and an additional RocketChat user for the bot the first time you launch RocketChat. The bot's name and credentials need to match the ones in the `docker-compose.yaml` and needs to include the `bot` role.

We also use a slightly modified mongodb container that contains a simple healthcheck, so that we can ensure Mongo is healthly before other things start up.

You can find more zcode (z5) games here: https://ifarchive.org/indexes/if-archiveXgamesXzcode.html


## Instructions

* Here are some very basic instructions on how you might use this:

* In a local terminal run: `cd compose/unix; docker compose up -d`
* Open: http://127.0.0.1:3000
* Click: Register a new account
   * Name: admin
   * Email: admin@example.com
   * Password: p2ssw0rd
   * Re-enter Password: p2ssw0rd
* Click: Register a New Account
* Wait...The account setup will take at least a minute, while the server sets everything up for the first time. Don't click the blue button that now says "Please wait..." again. It won't really hurt anything, but it won't help either.
* Once it is done you will get a prompt titled: "Register Username"
   * Username: admin
   * Click: Use this Username
* Now you are in the chat client UI.
* Create a user for the chat bot.
* Click the top of the left sidebar, where you see your username and status displayed.
* In the menu that pops up click "Administration"
* The left sidebar will be replaced by the Administration panel. In the Administration panel click: Users
* On the far right side, click the + symbol, to add a user.
   * Name: hubot
   * Username: hubot
   * Email: hubot@example.com
   * Click: Verified (Green)
   * Password: bot-pw!
   * Click: Require password change (Red)
   * Select a role: bot
   * Click: Add Role
   * Uncheck: Send welcome email
   * Click: Save
* At the top of the left side Administration panel, click the X icon to close the panel.
* In the left side panel under `channels`, click `general`.
* In a local terminal run: `docker compose restart hubot`
* In the message windows at the bottom of the `general` chat screen, type `/invite @hubot` to invite the bot.
* Then type `@hubot time`, or as a shortcut `. time`, to test that the bot is responding.
* Finally try typing `. meme One does not simply launch a complex web service with docker-compose!`
* For some fun:
* Type `/create zmachine` in the chat window
* click on the new `zmachine` channel.
* In chat type: `/invite @hubot`
* In chat type: `. z start adventure`
* In chat type: `look`
* In chat type: `e`
* In chat type: `examine keys`
* In chat type: `get keys`
* In chat type: `. z save firstgame`
* In chat type: `. z stop`
* In chat type: `. z start adventure`
* In chat type: `. z restore firstgame`
