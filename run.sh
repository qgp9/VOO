source ./.env.$1
cd hubot
LOG=logs/log-$1-$(date +%Y-%m-%dT%H:%M%S).txt
mkdir -p logs
touch $LOG
ls logs/log-$1-* | xargs -I% zip -r %.zip %
./bin/hubot -a slack --name voo --alias v | tee -a $LOG
