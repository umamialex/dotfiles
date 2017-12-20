#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT key:" && \
apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 \
&& \

log "Adding MongoDB APT source:" && \
echo \
  "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-3.6.list \
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
