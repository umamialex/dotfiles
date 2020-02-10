#!/bin/bash

. ./apt-init/log.sh && \

log "Installing git config:" && \
sudo -u $USER ln -rsfn .gitconfig ~/.gitconfig && \

log "Installing global gitignore:" && \
sudo -u $USER ln -rsfn .gitignore_global ~/.gitignore_global && \

log "Installing .vimrc:" && \
sudo -u $USER ln -rsfn .vimrc ~/.vimrc && \

log "Installing .eslintrc:" && \
sudo -u $USER ln -rsfn .eslintrc ~/.eslintrc && \

log "Installing fish config directory:" && \
sudo -u $USER mkdir -p ~/.config/fish && \

log "Installing fish config:" && \
sudo -u $USER ln -rsfn config.fish ~/.config/fish/config.fish && \
sudo -u $USER ln -rsfn config.fish ~/.config/fish/env.fish && \

log "Installing vim bundles:" && \
sudo -u $USER ./vim-bundle-init.sh && \

log "Installing Fisherman:" && \
sudo -u $USER \
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher && \

log "Installing fish plugins:" && \
sudo -u $USER fish -c "fisher add edc/bass" && \

log "Installing tmux plugin manager:" && \
rm -rf ~/.tmux/plugins/tmp && \
sudo -u $USER git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \

log "Installing .tmux.conf:" && \
sudo -u $USER ln -rsfn .tmux.conf ~/.tmux.conf
