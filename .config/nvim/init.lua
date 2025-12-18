-- The goal is to keep this <300 lines and keep maintenance at a minimum. This means external connections
-- re: AI, Copilot, etc are a non starter.
-- Basic functionality should include:
--     1. LSP which just works by default
--     2. TreeSitter Support for the languages I use
--     3. Decent aesthetics

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('gruvbox').setup({
                contrast = "hard"
            })
            vim.cmd("colorscheme gruvbox")
        end
    },
    { "nvim-lua/plenary.nvim" },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup({
                defaults = {
                    prompt_prefix = "❯ ",
                    selection_caret = "❯ ",
                    file_ignore_patterns = {
                        "node_modules", ".git/", "target/", "*.class", ".bloop/"
                    },
                    layout_config = {
                        horizontal = { preview_width = 0.55 },
                    },
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                },
                pickers = {
                    find_files = { theme = "ivy" },
                    live_grep = { theme = "ivy" },
                    buffers = { theme = "ivy" },
                },
            })
        end
    },
    {
        'theprimeagen/harpoon',
        branch = "harpoon2",
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                }
            })
        end
    },
    { 'mason-org/mason.nvim',           version = "^1.0.0" },
    { 'mason-org/mason-lspconfig.nvim', version = "^1.0.0" },
    { 'neovim/nvim-lspconfig' },
    { "lukas-reineke/lsp-format.nvim",  config = true },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp', group_index = 1, priority = 100 },
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                window = {
                    completion = { border = 'single' },
                    documentation = { border = 'single' },
                },
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'go', 'rust', 'java', 'scala', 'lua', 'python', 'c', 'cpp' },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
})

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 20

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'

vim.opt.termguicolors = true

-- Better movement in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>r', builtin.live_grep)
vim.keymap.set('n', '<leader>b', builtin.buffers)

local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '[n', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']n', vim.diagnostic.goto_next, opts)
end


require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls', 'rust_analyzer', 'gopls', 'pyright', 'clangd', 'jdtls'
    },
    handlers = {
        function(server_name)
            local config = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            lspconfig[server_name].setup(config)
        end,
        ['lua_ls'] = function()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } },
                    },
                },
            })
        end,
    },
})

vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "■",
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'single',
        source = 'if_many',
        header = '',
        prefix = '',
    },
})
