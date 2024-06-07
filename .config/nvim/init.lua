-- ###############
-- ### Plugins ###
-- ###############
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {
                    dark0_hard = '#161616',
                    -- dark0_hard = '#000000',
                    bright_green = "#A9B665",
                }
            })
            vim.cmd([[colorscheme gruvbox]])
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = true,
                },
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "meuter/lualine-so-fancy.nvim",
        },
        opts = {
            options = {
                theme = "gruvbox",
                globalstatus = true,
                icons_enabled = true,
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {
                        "alfa-nvim",
                        "help",
                        "neo-tree",
                        "Trouble",
                        "spectre_panel",
                        "toggleterm",
                    },
                    winbar = {},
                },
            },
            sections = {
                lualine_a = {
                    { "fancy_mode", width = 3 }
                },
                lualine_b = {
                    "fancy_branch",
                },
                lualine_x = {
                    "fancy_lsp_servers",
                    "progress",
                },
                lualine_y = {
                    {
                        "fancy_filetype",
                        ts_icon = ""
                    },
                },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "neo-tree", "lazy" },
        }
    },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    { 'nvim-lua/plenary.nvim' },
    {
        "folke/todo-comments.nvim",
    },
    {
        'scalameta/nvim-metals',
        config = function()
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    require("metals").initialize_or_attach({})
                end,
                group = nvim_metals_group,
            })
        end
    },
    {
        'folke/trouble.nvim',
        opts = {
            icons = true,
            fold_open = "v",      -- icon used for open folds
            fold_closed = ">",    -- icon used for closed folds
            indent_lines = false, -- add an indent guide below the fold icons
            signs = {
                error = "error",
                warning = "warn",
                hint = "hint",
                information = "info"
            },
            use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'go', 'gomod', 'lua', 'vimdoc', 'vim', 'bash', 'markdown',
                    'markdown_inline', 'c', 'rust', 'cpp', 'yaml', 'toml', 'java',
                },
                indent = { enable = true },
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                    live_grep = {
                        theme = "ivy",
                    }
                },
            }
        end

    },
    { 'theprimeagen/harpoon' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
        }
    },
    -- Autocompletion
    {
        "L3MON4D3/LuaSnip",
    },
    {
        'hrsh7th/nvim-cmp',
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "rafamadriz/friendly-snippets" },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { "lukas-reineke/lsp-format.nvim", config = true },
})

local lsp_zero = require('lsp-zero')
lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[n', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']n', vim.diagnostic.goto_next, opts)
end)

local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
require('luasnip.loaders.from_vscode').lazy_load()


cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
        { name = "cmp_luasnip" },
        { name = "luasnip" },
        { name = "friendly-snippets" },
        { name = "copilot" },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    })
})

vim.diagnostic.config { virtual_text = false }

-- ################
-- ### Settings ###
-- ################
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.scrolloff = 20
vim.opt.wrap = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.g.mapleader = " "
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = "90"

-- ##############
-- ### Remaps ###
-- ##############
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>ll", "<cmd>set background=light<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dd", "<cmd>set background=dark<cr>", { silent = true, noremap = true })

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>r', builtin.live_grep, {})

-- clear copy buffer
vim.keymap.set('n', '<leader>dp', "<cmd>dp+<CR>", { silent = true })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>=", '<cmd>resize +10<cr>')
vim.keymap.set("n", "<leader>-", '<cmd>resize -10<cr>')
