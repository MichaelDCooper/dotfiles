vim.g.mapleader = " "

local o = vim.o
local opt = vim.opt

o.relativenumber = true
o.number = true
opt.cc = {90}
o.hlsearch = true
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.autoindent = 4
opt.scrolloff = 24
o.ttyfast = true
opt.termguicolors = true
vim.cmd 'set guicursor=i:block'

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')
-- Language Specific
Plug('darrikonn/vim-gofmt', { ['do'] = ':GoUpdateBinaries' })

-- Utils
Plug('ms-jpq/chadtree', {branch = 'chad', ['do'] = 'python3 -m chadtree deps'})
Plug 'tpope/vim-commentary'
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- Themes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] =  ':TSUpdate'})
vim.call('plug#end')


vim.cmd [[
  colorscheme nvcode
  set termguicolors
]]

require('nvim-lsp-installer').setup {}
-- This should be automated
require'lspconfig'.gopls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
-- elixir ls might need more config
require'lspconfig'.elixirls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.jdtls.setup{}

vim.keymap.set('n', '<C-n>', '<cmd>CHADopen<CR>')
vim.keymap.set('n', '<Leader>f', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>r', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>')

