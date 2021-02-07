#!/bin/bash

. ./ubuntu/scripts/log.sh && \

clone() {
  FOLDER="$HOME/Development/$1" &&
  log "Cloning $1" && \
  if [ ! -d "$FOLDER" ]; then
    mkdir -p $FOLDER && \
    git clone "git@github.com:$1" "$FOLDER"
  fi && \
  if [ -n "$2" ]; then
    (cd $FOLDER && $2)
  fi
}
