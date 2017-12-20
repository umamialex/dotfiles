#!/bin/bash

. ./apt-init/log.sh && \

log "Downloading Node v8.x:" && \
curl -sL https://deb.nodesource.com/setup_8.x | bash -
