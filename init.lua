vim.g.mapleader = " "

local o = vim.o
local opt = vim.opt

o.relativenumber = true
o.number = true
opt.cc = { 90 }
o.hlsearch = true
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 4
o.autoindent = 4
opt.scrolloff = 24
o.ttyfast = true
opt.mouse = 'a'
vim.cmd 'set guicursor=i:block'
o.guitablabel = '%t'

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')
-- Language Specific
Plug('darrikonn/vim-gofmt', { ['do'] = ':GoUpdateBinaries' })

-- Utils
Plug('ms-jpq/chadtree', { branch = 'chad', ['do'] = 'python3 -m chadtree deps' })
Plug 'tpope/vim-commentary'
-- Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'alvarosevilla95/luatab.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug('ms-jpq/coq_nvim', {branch =  'coq', ['do'] = 'python3 -m coq deps'})
Plug('ms-jpq/coq.artifacts', {branch =  'artifacts'})
Plug ('ms-jpq/coq.thirdparty', {branch = '3p'})
-- Themes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.call('plug#end')

opt.termguicolors = true
vim.cmd 'colorscheme nvcode'

require 'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true } }

-- Chadtree settings
local chadtree_settings = { ["keymap.tertiary"] = { "n" }, theme = { ['text_colour_set'] = "solarized_dark" } }
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

vim.keymap.set('n', '<C-n>', '<cmd>CHADopen<CR>')
vim.keymap.set('n', '<Leader>f', '<cmd>Telescope find_files<CR>')

-- Telescope Settings
vim.keymap.set('n', '<Leader>r', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>')


-- LSP Settings
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>h', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require('nvim-lsp-installer').setup {}

local lspconfig = require('lspconfig')

vim.g.coq_settings = { auto_start = 'shut-up' }

local servers = { 'gopls', 'rust_analyzer', 'jedi_language_server', 'vimls', 'clangd', 'cmake', 'elixirls', 'graphql', 'html', 'bashls', 'dockerls', 'sumneko_lua', 'jdtls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end

require('luatab').setup {}
-- Trouble config
require('trouble').setup{}
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})


