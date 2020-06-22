#!/bin/bash

. ./apt-init/log.sh && \

log "Adding Cassandra APT key:" && \
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add - && \

log "Adding Cassandra APT source:" && \
echo \
  "deb https://downloads.apache.org/cassandra/debian 311x main" \
  | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list \
&& \

log "Updating APT:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Installing Cassandra:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  cassandra \
&& \

log "Starting cassandra service:" && \
service cassandra start
