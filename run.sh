#!/bin/bash

ENV=./.env.$1
LOG=logs/log-$1-$(date +%Y-%m-%dT%H%M%S).txt
HUBOT_DIR=./hubot

test -e $ENV && ./source $ENV
cd $HUBOT_DIR || exit 1
mkdir -p logs || exit 1
touch $LOG
logs/log-$1-* 2>/dev/null | xargs -I% zip -r %.zip %

./bin/hubot -a slack --name voo --alias v | tee -a $LOG

