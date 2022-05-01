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
set spell spelllang=en_us
set guicursor=i:block

call plug#begin('~/.vim/plugged')
 Plug 'elixir-editors/vim-elixir'
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-commentary'
 Plug 'mhinz/vim-startify'
 " Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'NLKNguyen/papercolor-theme'
 Plug 'morhetz/gruvbox'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
call plug#end()

syntax enable
colorscheme gruvbox
_init.lua                       coc.nvim                        glow.nvim                       lua                             nvim-treesitter                 vim-commentary                  vim-gofmt
autoload                        fzf                             init.vim                        nerdtree                        vim-airline                     vim-devicons
coc-settings.json               fzf.vim                         lightspeed.nvim                 nvcode-color-schemes.vim        vim-airline-themes              vim-elixir
