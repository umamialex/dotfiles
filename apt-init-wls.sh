#!/bin/bash

log() {
  echo && \
  echo "##################################################" && \
  echo "# $USER: $1" && \
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
  curl \
&& \

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
  fish \
  git \
  nodejs \
  silversearcher-ag \
  tmux \
  vim \
&& \

# User Configuration
log "Copying git config:" && \
sudo -u $USER cp .gitconfig ~/.gitconfig && \

log "Copying global git ignore:" && \
sudo -u $USER cp .gitignore_global ~/.gitignore_global && \

log "Coyping .vimrc:" && \
sudo -u $USER cp .vimrc ~/.vimrc && \

log "Copying .eslintrc:" && \
sudo -u $USER cp .eslintrc ~/.eslintrc && \

log "Creating fish config directory:" && \
sudo -u $USER mkdir -p ~/.config/fish && \

log "Copying fish config:" && \
sudo -u $USER cp config.fish ~/.config/fish/config.fish && \

log "Running vim bundle init:" && \
sudo -u $USER ./vim-bundle-init.sh && \

# Installing Fisherman
log "Installing Fisherman:" && \
sudo -u $USER \
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher && \

# Installing fish plugins:
log "Installing fish plugins:" && \
sudo -u $USER fish -c "fisher edc/bass" && \
sudo -u $USER fish -c "fisher spin" && \

# Global NPM Install
log "Enabling sudoless global npm install:" && \
sudo -u $USER mkdir ~/.npm-global && \
sudo -u $USER npm config set prefix '~/.npm-global' && \
sudo -u $USER export PATH=~/.npm-global/bin:$PATH

log "Running npm global init:" && \
sudo -u $USER NPM_CONFIG_PREFIX=~/.npm-global ./npm-global-init.sh && \

# Fix Permissions
log "Fixing permissions:" && \
chown -R $USER:$USER /home/$USER && \

# Set fish as default shell
log "Setting fish as default shell:" && \
echo "" >> /home/$USER/.bashrc && \
echo "fish; exit" >> /home/$USER/.bashrc && \

# Update default editor
log "Updating default editor:" && \
update-alternatives --config editor && \

log "Done!"
