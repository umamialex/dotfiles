echo "Initializing vim bundles..."

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
  cd ~/.vim/bundle && \
  git clone https://github.com/scrooloose/syntastic && \
  git clone https://github.com/dag/vim-fish && \
  git clone https://github.com/mxw/vim-jsx && \
  git clone https://github.com/othree/html5.vim && \
  git clone https://github.com/hail2u/vim-css3-syntax

echo "Done"
