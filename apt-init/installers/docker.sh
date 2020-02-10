#!/bin/bash

. ./apt-init/log.sh && \

log "Performing update:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Install prerequisites:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
&& \

log "Adding Docker APT key:" && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \

log "Check fingerprint:" && \
apt-key fingerprint OEBFCD88 && \

log "Add repository:" && \
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable" && \

log "Performing update:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \


log "Installing docker:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  docker-ce
