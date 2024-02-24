#!/bin/bash

# Note: This script has not been kept 100% up-to-date and likely
# differs somewhat from the current docker-compose.yaml file.

# This is here just to keep people from really running this.
exit 1

# The actual script

set -e
set -u

if [ $# -ne 0 ] && [ ${1} == "down" ]; then
  docker container rm -f hubot || true
  docker container rm -f zmachine || true
  docker container rm -f rocketchat || true
  docker container rm -f mongodb || true
  docker network rm botnet || true
  echo "Environment torn down..."
  exit 0
fi

# Global Settings
export PORT="3000"
export ROOT_URL="http://127.0.0.1:3000"
export MONGO_URL="mongodb://mongodb:27017/rocketchat?replicaSet=rs0"
export MONGO_OPLOG_URL="mongodb://mongodb:27017/local?replicaSet=rs0"
export MAIL_URL="smtp://smtp.email"
export RESPOND_TO_DM="true"
export HUBOT_ALIAS=". "
export LISTEN_ON_ALL_PUBLIC="true"
export ROCKETCHAT_AUTH="password"
export ROCKETCHAT_URL="rocketchat:3000"
export ROCKETCHAT_ROOM=""
export ROCKETCHAT_USER="hubot"
export ROCKETCHAT_PASSWORD="bot-pw!"
export BOT_NAME="bot"
export EXTERNAL_SCRIPTS="hubot-help,hubot-diagnostics,hubot-zmachine"
export HUBOT_ZMACHINE_SERVER="http://zmachine:80"
export HUBOT_ZMACHINE_ROOMS="zmachine"
export HUBOT_ZMACHINE_OT_PREFIX="ot"

docker image build -t spkane/mongo:5.0 ./mongodb/docker

docker image push spkane/mongo:5.0
docker image pull spkane/zmachine-api:latest
docker image pull rocketchat/rocket.chat:6.5.2
docker image pull rocketchat/hubot-rocketchat:latest

docker container rm -f hubot || true
docker container rm -f zmachine || true
docker container rm -f rocketchat || true
docker container rm -f mongodb || true

docker network rm botnet || true

docker network create -d bridge botnet

docker container run -d \
  --name=mongodb \
  --network=botnet \
  --restart unless-stopped \
  -v $(pwd)/mongodb/data/db:/bitnami/mongodb \
  spkane/mongo:5.0 \
  mongod --oplogSize 128 --replSet rs0
sleep 5
docker container run -d \
  --name=rocketchat \
  --network=botnet \
  --restart unless-stopped  \
  -v $(pwd)/rocketchat/data/uploads:/app/uploads \
  -p 3000:3000 \
  -e PORT=${PORT} \
  -e ROOT_URL=${ROOT_URL} \
  -e MONGO_URL=${MONGO_URL} \
  -e MONGO_OPLOG_URL=${MONGO_OPLOG_URL} \
  -e MAIL_URL=${MAIL_URL} \
  rocketchat/rocket.chat:6.5.2
docker container run -d \
  --name=zmachine \
  --network=botnet \
  --restart unless-stopped  \
  -v $(pwd)/zmachine/saves:/root/saves \
  -v $(pwd)/zmachine/zcode:/root/zcode \
  -p 3002:80 \
  spkane/zmachine-api:latest
docker container run -d \
  --name=hubot \
  --network=botnet \
  --restart unless-stopped  \
  -v $(pwd)/hubot/scripts:/home/hubot/scripts \
  -p 3001:8080 \
  -e RESPOND_TO_DM="true" \
  -e HUBOT_ALIAS=". " \
  -e LISTEN_ON_ALL_PUBLIC="true" \
  -e ROCKETCHAT_AUTH="password" \
  -e ROCKETCHAT_URL="rocketchat:3000" \
  -e ROCKETCHAT_ROOM="" \
  -e ROCKETCHAT_USER="hubot" \
  -e ROCKETCHAT_PASSWORD="bot-pw!" \
  -e BOT_NAME="bot" \
  -e EXTERNAL_SCRIPTS="hubot-help,hubot-diagnostics,hubot-zmachine" \
  -e HUBOT_ZMACHINE_SERVER="http://zmachine:80" \
  -e HUBOT_ZMACHINE_ROOMS="zmachine" \
  -e HUBOT_ZMACHINE_OT_PREFIX="ot" \
  rocketchat/hubot-rocketchat:latest

echo "Environment setup..."
exit 0
