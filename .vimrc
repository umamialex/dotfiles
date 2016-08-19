execute pathogen#infect()

syntax on
filetype plugin indent on

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set viminfo='100,<500,s10,h
set backspace=2
set colorcolumn=80
set hlsearch
highlight ColorColumn ctermbg=3

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_sass_checkers = ['sass_lint']
let g:syntastic_scss_checkers = ['sass_lint']

let g:syntastic_javascript_checkers = ["eslint"]

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd BufNewFile,BufRead *.eslintrc set syntax=json
  autocmd BufNewFile,BufRead *.babelrc set syntax=json
endif
