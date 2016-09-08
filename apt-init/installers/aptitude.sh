#!/bin/bash

. ./apt-init/log.sh && \

log "Installing aptitude:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  aptitude
