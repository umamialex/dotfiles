#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Installing global pip packages:" && \

pip install \
  huggingface_hub
