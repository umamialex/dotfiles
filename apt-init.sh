#!/bin/bash

. ./apt-init/log.sh && \

./apt-init/update.sh && \

./apt-init/installers/aptitude.sh && \
./apt-init/installers/core.sh && \

# Docker Prerequisites

log "Creating apt-key for docker:" && \
apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
&& \

log "Adding Docker repo:" && \
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' \
  >> /etc/apt/sources.list.d/docker.list \
&& \

./apt-init/update.sh && \

log "Purging docker packages:" && \
aptitude purge lxc-docker && \

log "Clearing docker cache:" && \
apt-cache policy docker-engine && \

./apt-init/prerequisites/fish.sh && \
./apt-init/prerequisites/node.sh && \

./apt-init/update.sh && \
./apt-init/upgrade.sh && \

./apt-init/installers/dev.sh && \
log "Installing docker-engine:" && \
aptitude install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  -f \
  docker-engine \
&& \

# Docker Configuration
log "Creating docker user group:" && \
groupadd --force docker && \

log "Adding current user to docker group:" && \
usermod -aG docker $USER && \

log "Starting docker service:" && \
service docker start && \

./apt-init/installers/config.sh && \
./apt-init/installers/npm.sh && \
./apt-init/installers/mongodb.sh && \

./apt-init/fix-permissions.sh && \

# Set fish as default shell
log "Setting fish as default shell:" && \
usermod -s `which fish` $USER && \
usermod -s `which fish` root && \

./apt-init/update-sudoers.sh && \

./apt-init/update-defaults.sh && \

log "Done!"
