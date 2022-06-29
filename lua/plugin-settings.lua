vim.opt.termguicolors = true
vim.cmd "colorscheme gruvbox"
require 'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true } }

-- LSP Settings
local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

require('nvim-lsp-installer').setup {}

local lspconfig = require('lspconfig')

vim.g.coq_settings = { auto_start = 'shut-up' }

local servers = { 'gopls', 'rust_analyzer', 'jedi_language_server', 'vimls', 'clangd', 'cmake', 'elixirls', 'graphql', 'html', 'bashls', 'dockerls', 'sumneko_lua', 'jdtls' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({}))
end

require('telescope').setup {
    pickers = {
        find_files = {
            theme = 'ivy',
        },
        live_grep = {
            theme = 'ivy',
        },
        buffers = {
            theme = 'ivy',
        },
    }
}
require('luatab').setup {}
require('trouble').setup {}
require('lualine').setup()
