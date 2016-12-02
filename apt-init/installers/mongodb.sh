#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT key:" && \
apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
&& \

log "Adding MongoDB APT source:" && \
echo \
  "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-3.4.list \
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
