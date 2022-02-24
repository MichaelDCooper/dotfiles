set relativenumber
set number
set cc=90
set hlsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set scrolloff=24
set ttyfast
" set guifont=Jetbrains\ Mono
set spell spelllang=en_us
set guicursor=i:block

call plug#begin('~/.vim/plugged')
 Plug 'elixir-editors/vim-elixir'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-commentary'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'NLKNguyen/papercolor-theme'
 " For fuzzy finding
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

syntax enable
set background=dark
colorscheme PaperColor
