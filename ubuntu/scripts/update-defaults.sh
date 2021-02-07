#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Updating default editor:" && \
update-alternatives --set editor /usr/bin/vim.basic
