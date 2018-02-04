This is intended to be a demonstration of using Docker Compose to launch a series of semi-complex applications that include a datastore, web UI, and chat bot.

Note that you'll need to create your admin user and an additional RocketChat user for the bot the first time you launch RocketChat. The bot's name and credentials need to match the ones in the `docker-compose.yaml` and needs to include the +bot+ role.

We also use a slightly modified mongodb container that contains a simple healthcheck, so that we can ensure Mongo is healthly before other things start up.
