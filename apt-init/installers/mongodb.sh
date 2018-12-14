#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT key:" && \
curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9DA31620334BD75D9DCB49F368818C72E52529D4" | apt-key add && \

log "Adding MongoDB APT source:" && \
echo \
  "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-4.0.list \
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

log "Adding init.d service script:" && \
wget https://raw.githubusercontent.com/mongodb/mongo/master/debian/init.d \
  -O /etc/init.d/mongod \
&& \
chmod 755 /etc/init.d/mongod && \

log "Starting mongod service:" && \
service mongod start
