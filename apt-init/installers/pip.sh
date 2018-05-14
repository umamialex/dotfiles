#/bin/bash

. ./apt-init/log.sh && \

log "Installing global pip packages:" && \
sudo pip3 install thefuck
