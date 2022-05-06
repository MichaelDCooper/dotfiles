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
 Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }

 " Utils
 Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
 Plug 'tpope/vim-commentary'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'williamboman/nvim-lsp-installer'
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'

 " Themes
 Plug 'christianchiarulli/nvcode-color-schemes.vim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

colorscheme nvcode

lua require('nvim-lsp-installer').setup {}
" This should be automated
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.jedi_language_server.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.cmake.setup{}
" elixir ls might need more config
lua require'lspconfig'.elixirls.setup{}
lua require'lspconfig'.graphql.setup{}
lua require'lspconfig'.html.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.dockerls.setup{}
lua require'lspconfig'.sumneko_lua.setup{}
lua require'lspconfig'.jdtls.setup{}

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

let g:chadtree_settings = { "keymap.tertiary": ["n"], "theme": {"text_colour_set": "solarized_dark"} }
let mapleader = ","
nnoremap <C-n> <cmd>CHADopen<CR>

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set termguicolors
