#!/bin/bash

. ./apt-init/log.sh && \

log "Installing vim pathogen:" && \

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd ~/.vim/bundle && \
  rm -rf Vundle.vim && \
  git clone https://github.com/VundleVim/Vundle.vim.git && \
  vim +PluginInstall +qall
