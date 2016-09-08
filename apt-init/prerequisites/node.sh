#!/bin/bash

. ./apt-init/log.sh && \

log "Downloading Node v6.x:" && \
curl -sL https://deb.nodesource.com/setup_6.x | bash -
