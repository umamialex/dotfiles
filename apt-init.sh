#!/bin/bash

log() {
  echo && \
  echo "##################################################" && \
  echo "# $1" && \
  echo "##################################################" && \
  echo
}

log "Running update #1:" && \
apt-get update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Installing aptitude:" && \
apt-get install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  aptitude \
&& \

log "Installing core packages:" && \
aptitude install \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
  curl \
&& \

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

log "Running update #2:" && \
aptitude update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Purging docker packages:" && \
aptitude purge lxc-docker && \

log "Clearing docker cache:" && \
apt-cache policy docker-engine && \

# Fish Prerequisites
log "Adding fish repo:" && \
apt-add-repository \
  -y \
  ppa:fish-shell/release-2 \
&& \

# NodeJS Prerequisites
log "Downloading Node v6.x:" && \
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \

log "Running update #3:" && \
aptitude update \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

log "Running full upgrade:" && \
aptitude full-upgrade \
  -y \
  -q \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

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
  libltd17 \
  libsystemd0 \
  build-essential \
  docker-engine \
  fish \
  git \
  nodejs \
  silversearcher-ag \
  tmux \
  vim \
&& \

# Docker Configuration
log "Creating docker user group:" && \
groupadd --force docker && \

log "Adding current user to docker group:" && \
usermod -aG docker $USER && \

log "Starting docker service:" && \
service docker start && \

# User Configuration
log "Copying git config:" && \
cp .gitconfig ~/.gitconfig && \

log "Copying global git ignore:" && \
cp .gitignore_global ~/.gitignore_global && \

log "Coyping .vimrc:" && \
cp .vimrc ~/.vimrc && \

log "Copying .eslintrc:" && \
cp .eslintrc ~/.eslintrc && \

log "Creating fish config directory:" && \
mkdir -p ~/.config/fish && \

log "Coyping fish config:" && \
cp config.fish ~/.config/fish/config.fish && \

log "Running vim bundle init:" && \
./vim-bundle-init.sh && \

log "Running npm global init:" && \
./npm-global-init.sh && \

# Fix Permissions
log "Fixing permission for npm:" && \
chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share} && \

log "Fixing permissions for ~:" && \
chown -R $(whoami) ~ && \

log "Done!"
