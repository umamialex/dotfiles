#!/bin/bash

. ./apt-init/log.sh && \

log "Installing git config:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .gitconfig ~/.gitconfig && \

log "Installing global gitignore:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .gitignore_global ~/.gitignore_global && \

log "Installing .vimrc:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .vimrc ~/.vimrc && \

log "Installing .eslintrc:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .eslintrc ~/.eslintrc && \

log "Installing fish config directory:" && \
sudo --preserve-env=HOME -u $USER mkdir -p ~/.config/fish && \

log "Installing fish config:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn config.fish ~/.config/fish/config.fish && \

log "Installing vim bundles:" && \
sudo --preserve-env=HOME -u $USER ./apt-init/installers/pathogen.sh && \

log "Installing Fisherman:" && \
sudo --preserve-env=HOME -u $USER \
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher && \

log "Installing fish plugins:" && \
sudo --preserve-env=HOME -u $USER fish -c "fisher add edc/bass" && \
sudo --preserve-env=HOME -u $USER fish -c "fisher add fishpkg/fish-prompt-metro" && \

log "Installing tmux plugin manager:" && \
rm -rf ~/.tmux/plugins/tmp && \
sudo --preserve-env=HOME -u $USER git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \

log "Installing .tmux.conf:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .tmux.conf ~/.tmux.conf && \
sudo --preserve-env=HOME -u $USER ./apt-init/installers/tpm.sh
