#!/bin/bash

. ./apt-init/log.sh && \

log "Updating default editor:" && \
update-alternatives --set editor /usr/bin/vim.basic
