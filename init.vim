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
" Language Specific
 Plug 'elixir-editors/vim-elixir'

 " Utils
 Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }
 Plug 'scrooloose/nerdtree'
 Plug 'tpope/vim-commentary'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'

 " Themes
 Plug 'christianchiarulli/nvcode-color-schemes.vim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'vim-airline'
 Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme gruvbox

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let mapleader = ","
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-x> :NERDTreeClose<CR>

nnoremap <leader>r :Rg <CR>
