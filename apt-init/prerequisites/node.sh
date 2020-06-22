#!/bin/bash

. ./apt-init/log.sh && \

VERSION=node_14.x && \
DISTRO="$(lsb_release -s -c)" && \

log "Add NodeSource signing key:" && \
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add - && \

log "Add NodeSource repository:" && \
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
