#!/bin/bash

echo "Initializing vim bundles..."

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd ~/.vim/bundle && \
  git clone https://github.com/dag/vim-fish && \
  git clone https://github.com/digitaltoad/vim-pug && \
  git clone https://github.com/elzr/vim-json && \
  git clone https://github.com/evanmiller/nginx-vim-syntax && \
  git clone https://github.com/gcorne/vim-sass-lint && \
  git clone https://github.com/hail2u/vim-css3-syntax && \
  git clone https://github.com/mxw/vim-jsx && \
  git clone https://github.com/plasticboy/vim-markdown && \
  git clone https://github.com/othree/html5.vim && \
  git clone https://github.com/othree/html5-syntax.vim && \
  git clone https://github.com/othree/javascript-libraries-syntax.vim && \
  git clone https://github.com/othree/yajs.vim && \
  git clone https://github.com/pangloss/vim-javascript && \
  git clone https://github.com/scrooloose/syntastic

echo "Done"
