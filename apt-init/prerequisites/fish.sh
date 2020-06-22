#!/bin/bash

. ./apt-init/log.sh && \

log "Adding fish repo:" && \
apt-add-repository \
  -y \
  ppa:fish-shell/release-3
