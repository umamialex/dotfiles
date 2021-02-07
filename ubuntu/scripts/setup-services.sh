#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Setting up MongoDB:" && \
service mongod start && \
systemctl enable mongod && \

log "Setting up Redis:" && \
service redis-server start && \
systemctl enable redis-server
