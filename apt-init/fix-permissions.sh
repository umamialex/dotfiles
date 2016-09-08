#!/bin/bash

. ./apt-init/log.sh && \

log "Fixing permissions:" && \
chown -R $USER:$USER /home/$USER
