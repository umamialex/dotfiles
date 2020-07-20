set nocompatible
filetype off

syntax enable

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'fenetikm/falcon'
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'elzr/vim-json'
Plugin 'w0rp/ale'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'flazz/vim-colorschemes'
Plugin 'felixhummel/setcolors.vim'
Plugin 'mhartington/oceanic-next'
Plugin 'ruanyl/coverage.vim'
Plugin 'nvie/vim-flake8'
Plugin 'styled-components/vim-styled-components'
Plugin 'PProvost/vim-ps1'
Plugin 'leafgarland/typescript-vim'
Plugin 'google/vim-jsonnet'
call vundle#end()

filetype plugin indent on

set shell=/bin/bash
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set viminfo='100,<500,s10,h
set backspace=2
set colorcolumn=80
set hlsearch
set ruler
highlight ColorColumn ctermbg=blue ctermfg=white
highlight Normal ctermfg=253 ctermbg=black
highlight Visual cterm=reverse ctermbg=NONE
highlight ALEError ctermbg=52

set statusline+=%#warningmsg#
set statusline+=%*

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

let g:js_context_colors_enabled = 0
let g:js_context_colors_colorize_comments = 1
let g:js_context_colors_highlight_function_names = 1
let g:js_context_colors_block_scope = 1
let g:js_context_colors_jsx = 1

let g:ale_linter_aliases = {'jsx': ['css', 'javascript'], 'js': ['css', 'javascript'], 'ts': ['css', 'javascript']}
let b:ale_linters = ['flake8', 'eslint', 'yamllint', 'stylelint']

au FileType java setl sw=4 sts=4 et

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd BufNewFile,BufRead *.eslintrc set syntax=json
  autocmd BufNewFile,BufRead *.babelrc set syntax=json
  autocmd BufNewFile,BufRead *.ps1 set syntax=ps1
  autocmd BufNewFile,BufRead *.jsonnet set syntax=jsonnet
endif
