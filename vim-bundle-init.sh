#!/bin/bash

echo "Initializing vim bundles..."

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd ~/.vim/bundle && \
  git clone https://github.com/VundleVim/Vundle.vim.git && \

echo "Done"
