#!/bin/bash

. ./apt-init/log.sh && \

log "Installing tpm plugins:" && \

tmux new-session -d "sleep 1" && \
sleep 0.1 && \
~/.tmux/plugins/tpm/bin/install_plugins
