#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Installing global pip packages:" && \

pipx install \
  huggingface_hub
