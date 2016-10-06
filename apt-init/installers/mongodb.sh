#!/bin/bash

. ./apt-init/log.sh && \

log "Adding MongoDB APT Key:" && \
apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv EA312927 \
&& \

log "Adding MongoDB APT Soure:" && \
echo \
  "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" \
  | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
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

log "Copying mongod.service:" && \
cp mongod.service /lib/systemd/system/mongod.service && \

log "Starting mongod service:" && \
service mongod start
