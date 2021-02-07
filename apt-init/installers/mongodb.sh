#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT key:" && \
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -

log "Adding MongoDB APT source:" && \
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-4.4.list \
&& \

log "Updating APT:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Installing MongoDB:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  mongodb-org \
&& \

log "Starting mongod service:" && \
service mongod start
