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
  libltdl7 \
  libsystemd0 \
  build-essential \
  fish \
  git \
  htop \
  openjdk-8-jdk \
  nodejs \
  yarn \
  silversearcher-ag \
  tmux \
  vim \
  python3-dev \
  python3-pip \
  redis-server
