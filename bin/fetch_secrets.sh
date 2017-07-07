#!/bin/bash

URL="hard-to-find-voice.surge.sh"
LIST="list"
SDIR="./.secrets/"
DDIR="./.data/"

mkdir -p $SDIR $DDIR
curl $URL/$LIST | while read x; do curl $URL/$x > $SDIR/$x; done
gpg $SDIR/*.gpg
cd $SDIR
find . -type f | grep -vf list | xargs -I% mv % ../$DDIR/
