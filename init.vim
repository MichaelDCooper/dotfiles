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
set guicursor=i:block

call plug#begin('~/.vim/plugged')
" Language Specific
 Plug 'elixir-editors/vim-elixir'
 Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }

 " Utils
 Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
 Plug 'tpope/vim-commentary'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'

 " Themes
 Plug 'christianchiarulli/nvcode-color-schemes.vim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

colorscheme nvcode

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let g:chadtree_settings = { "keymap.tertiary": ["n"], "theme": {"text_colour_set": "solarized_dark"} }
" theme.icon_colour_set
" nerdtree_syntax_dark
let mapleader = ","
nnoremap <C-n> :CHADopen<CR>
nnoremap <leader>r :Rg <CR>

set termguicolors
