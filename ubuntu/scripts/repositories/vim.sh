#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Adding vim repo:" && \
apt-add-repository \
  -y \
  ppa:jonathonf/vim
