#!/bin/bash

. ./ubuntu/scripts/log.sh && \

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
sudo --preserve-env=HOME -u $USER ./ubuntu/scripts/installers/pathogen.sh && \

log "Installing Fisherman:" && \
sudo --preserve-env=HOME -u $USER fish -c \
  "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" && \

log "Installing fish plugins:" && \
sudo --preserve-env=HOME -u $USER fish -c "fisher install IlanCosman/tide" && \
sudo --preserve-env=HOME -u $USER fish -c "fisher install evanlucas/fish-kubectl-completions" && \
sudo --preserve-env=HOME -u $USER fish -c "fisher install fishpkg/fish-prompt-metro" && \

log "Installing tmux plugin manager:" && \
rm -rf ~/.tmux/plugins/tpm && \
sudo --preserve-env=HOME -u $USER git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \

log "Installing .tmux.conf:" && \
sudo --preserve-env=HOME -u $USER ln -rsfn .tmux.conf ~/.tmux.conf && \
sudo --preserve-env=HOME -u $USER ./ubuntu/scripts/installers/tpm.sh
