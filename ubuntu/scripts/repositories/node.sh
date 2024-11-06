#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Add NodeSource repository:" && \
curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh && \
sudo -E bash nodesource_setup.sh
