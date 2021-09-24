set nocompatible

call plug#begin('~/.vim/plugged')
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

set noswapfile

set number
set relativenumber

set list
set hlsearch

set splitright
set splitbelow

set shiftwidth=4
set softtabstop=4
set expandtab

set nowrap

set ignorecase
set smartcase

set hidden

set clipboard=unnamed

set encoding=utf-8

let mapleader = " "

nmap <leader>b :Buffers<CR>
nmap <leader>d :bdelete<CR>
nmap <leader>l :BLines<CR>
nmap <leader>L :exec("BLines ".expand("<cword>"))<CR>
nmap <leader>p :Files<CR>
nmap <leader>t :Tags<CR>

let g:fzf_buffers_jump = 1

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <leader>f :Rg 
nmap <leader>F :exec("Rg ".expand("<cword>"))<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "tomorrow"

set fillchars+=vert:│
highlight VertSplit cterm=none
highlight Search cterm=none ctermfg=Red ctermbg=White

let g:ale_sign_error = '> '
let g:ale_sign_warning = '- '
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 1
highlight clear ALESignColumnWithErrors
highlight clear ALESignColumnWithoutErrors
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEWarningSign ctermbg=none ctermfg=yellow
nmap <silent> <c-p> <Plug>(ale_previous_wrap)
nmap <silent> <c-n> <Plug>(ale_next_wrap)

nnoremap <c-w>\ :vsplit<CR>
nnoremap <c-w>- :split<CR>

nnoremap zz :x!<CR>
nnoremap zx :q!<CR>
nnoremap zq :cq<CR>

syntax enable
