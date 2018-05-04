#!/bin/bash

. ./apt-init/log.sh && \

log "Installing git config:" && \
sudo -u $USER ln -rs .gitconfig ~/.gitconfig && \

log "Installing global gitignore:" && \
sudo -u $USER ln -rs .gitignore_global ~/.gitignore_global && \

log "Installing .vimrc:" && \
sudo -u $USER ln -rs .vimrc ~/.vimrc && \

log "Installing .eslintrc:" && \
sudo -u $USER ln -rs .eslintrc ~/.eslintrc && \

log "Installing fish config directory:" && \
sudo -u $USER mkdir -p ~/.config/fish && \

log "Installing fish config:" && \
sudo -u $USER ln -rs config.fish ~/.config/fish/config.fish && \

log "Installing vim bundles:" && \
sudo -u $USER ./vim-bundle-init.sh && \

log "Installing Fisherman:" && \
sudo -u $USER \
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher && \

log "Installing fish plugins:" && \
sudo -u $USER fish -c "fisher edc/bass" && \
sudo -u $USER fish -c "fisher spin"
