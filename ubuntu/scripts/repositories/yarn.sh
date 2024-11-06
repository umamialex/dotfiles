#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Adding yarn repo:" && \
env COREPACK_ENABLE_DOWNLOAD_PROMPT=0 corepack enable
