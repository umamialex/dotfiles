#!/bin/bash

. ./ubuntu/scripts/log.sh && \

log "Running full upgrade:" && \
aptitude full-upgrade \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold"
