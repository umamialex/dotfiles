#!/bin/bash

. ./apt-init/log.sh && \

log "Downloading Node v14.x:" && \
curl -sL https://deb.nodesource.com/setup_14.x | bash -
