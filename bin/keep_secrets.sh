#!/bin/bash

URL="hard-to-find-voice.surge.sh"
LIST="list"
SDIR="./.secrets/"
DDIR="./.data/"

mkdir -p $SDIR $DDIR

gpg -c $DDIR/*
mv $DDIR/*.gpg $SDIR/
cd $SDIR
find . -type f > $LIST
./surge .
