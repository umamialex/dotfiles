#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT key:" && \
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - && \

log "Adding MongoDB APT source:" && \
echo \
  "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
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
