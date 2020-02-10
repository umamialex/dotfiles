#!/bin/bash

. ./apt-init/log.sh && \

log "Downloading Node v10.x:" && \
curl -sL https://deb.nodesource.com/setup_13.x | bash -
