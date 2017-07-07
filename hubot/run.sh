#!/bin/bash

ENV=../.data/env.${1:-vue}
LOG=logs/log-$1-$(date +%Y-%m-%dT%H%M%S).txt
HUBOT_DIR=.

source $ENV
cd $HUBOT_DIR || exit 1
mkdir -p logs || exit 1
touch $LOG
logs/log-$1-* 2>/dev/null | xargs -I% zip -r %.zip %

printenv | grep HUBOT
./bin/hubot -a slack --name voo --alias v | tee -a $LOG

