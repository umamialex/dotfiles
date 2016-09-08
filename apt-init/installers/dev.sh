#!/bin/bash

. ./apt-init/log.sh && \

log "Installing dev packages:" && \
aptitude install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  init-system-helpers \
  lsb-base \
  libdevmapper1.02.1 \
  libltd17 \
  libsystemd0 \
  build-essential \
  fish \
  git \
  nodejs \
  silversearcher-ag \
  tmux \
  vim
