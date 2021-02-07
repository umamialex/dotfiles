#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Adding nopassd to sudoers:" && \
echo "" >> /etc/sudoers && \
echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
