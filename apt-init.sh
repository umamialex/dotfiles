#!/bin/bash

apt-get update \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

apt-get install \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
&& \

# Docker Prerequisites

apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
&& \

echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' \
  >> /etc/apt/sources.list.d/docker.list \
&& \

apt-get update \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \
apt-get purge lxc-docker && \
apt-cache policy docker-engine && \

# Fish Prerequisites
apt-add-repository \
  -y \
  ppa:fish-shell/release-2 \
&& \

# NodeJS Prerequisites
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \

apt-get update \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

apt-get upgrade \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
&& \

apt-get install \
  -y \
  -qq \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  build-essential \
  docker-engine \
  fish \
  git \
  nodejs \
  silversearcher-ag \
  vim \
&& \

# Docker Configuration
groupadd --force docker && \
usermod -aG docker $USER && \
service docker start && \

# User Configuration
cp .gitconfig ~/.gitconfig && \
cp .gitignore_global ~/.gitignore_global && \

cp .vimrc ~/.vimrc && \

cp .eslintrc ~/.eslintrc && \

mkdir -p ~/.config/fish && \
cp config.fish ~/.config/fish/config.fish && \

./vim-bundle-init.sh && \
./npm-global-init.sh && \

# Fix Permissions
chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share} && \
chown -R $(whoami) ~
