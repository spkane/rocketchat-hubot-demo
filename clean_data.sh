#!/bin/bash

BASE="$(pwd)"

echo "This will reset all the persistant rocketchat-hubot-demo data"
echo "under ${BASE} !!!"
echo
echo "Are you sure this is what you want to do?"
read -p "You must type 'yes' to confirm: " -r
echo
if [[ $REPLY == "yes" ]]; then
  rm -rf ${BASE}/mongodb/data/db/*
  rm -rf ${BASE}/rocketchat/data/uploads/*
  rm -rf ${BASE}/zmachine/saves/*
  echo "completed"
else
  echo "aborted"
fi

