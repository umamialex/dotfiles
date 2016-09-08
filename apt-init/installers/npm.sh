#/bin/bash

. ./apt-init/log.sh && \

log "Installing global npm configuration:" && \
sudo -u $USER mkdir -p ~/.npm-global && \
sudo -u $USER npm config set prefix "~/.npm-global" && \

log "Installing global npm packages:" && \
sudo -u $USER NPM_CONFIG_PREFIX=~/.npm-global ./npm-global-init.sh
