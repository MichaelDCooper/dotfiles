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
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
            })
            vim.cmd("colorscheme gruvbox")
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
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "copilot",
            -- auto_suggestions_provider = "copilot",
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "meuter/lualine-so-fancy.nvim",
        },
        opts = {
            options = {
                globalstatus = true,
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    { "fancy_mode", width = 3 }
                },
                lualine_b = {
                    "fancy_branch",
                    "fancy_diff",
                },
                lualine_c = {
                    { "fancy_cwd", substitute_home = true }
                },
                lualine_x = {
                    { "fancy_macro" },
                    { "fancy_diagnostics" },
                    { "fancy_searchcount" },
                    { "fancy_location" },
                },
                lualine_y = {
                    { "fancy_filetype", ts_icon = "" }
                },
                lualine_z = {
                    { "fancy_lsp_servers" }
                },
            },
        }
    },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    { 'nvim-lua/plenary.nvim' },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    },
    -- {
    --     "mfussenegger/nvim-jdtls",
    --     ft = { "java" },
    --     config = function()
    --         local on_attach = function(client, bufnr)
    --             local function buf_set_keymap(...)
    --                 vim.api.nvim_buf_set_keymap(bufnr, ...)
    --             end
    --             local function buf_set_option(...)
    --                 vim.api.nvim_buf_set_option(bufnr, ...)
    --             end

    --             buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    --             local opts = { noremap = true, silent = true }

    --             require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    --             require('jdtls.dap').setup_dap_main_class_configs()

    --             -- Follows lsp maps defined below
    --             buf_set_keymap("n", "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    --             buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    --             buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    --             buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    --             buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    --             buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    --             buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    --             buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    --             buf_set_keymap("n", "[n", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    --             buf_set_keymap("n", "]n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    --             client.server_capabilities.document_formatting = true
    --         end
    --         local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --         local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    --         local java_debug_path = vim.fn.glob(
    --             vim.fn.stdpath("data") ..
    --             "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
    --         local config = {
    --             cmd = {
    --                 "java",
    --                 "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    --                 "-Dosgi.bundles.defaultStartLevel=4",
    --                 "-Declipse.product=org.eclipse.jdt.ls.core.product",
    --                 "-Dlog.protocol=true",
    --                 "-Dlog.level=ALL",
    --                 "-Xmx1g",
    --                 "--add-modules=ALL-SYSTEM",
    --                 "--add-opens",
    --                 "java.base/java.util=ALL-UNNAMED",
    --                 "--add-opens",
    --                 "java.base/java.lang=ALL-UNNAMED",
    --                 "-jar",
    --                 vim.fn.expand(
    --                     "~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
    --                 ),
    --                 "-configuration",
    --                 vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/config_mac"),
    --                 "-data",
    --                 vim.fn.expand("~/.cache/jdtls/workspace") .. project_name,
    --             },
    --             init_options = {
    --                 bundles = {
    --                     java_debug_path
    --                 }
    --             },

    --             root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

    --             capabilities = capabilities,
    --             on_attach = on_attach,
    --         }
    --         require("jdtls").start_or_attach(config)
    --     end,
    -- },
    {
        'scalameta/nvim-metals',
        config = function()
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    require("metals").initialize_or_attach({
                        settings = {
                            showImplicitArguments = true,
                        },
                    })
                end,
                group = nvim_metals_group,
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'go', 'gomod', 'lua', 'markdown_inline', 'c', 'rust', 'cpp', 'yaml', 'toml', 'java', },
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
        branch = '0.1.x',
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        theme = "ivy",
                    },
                    live_grep = {
                        theme = "ivy",
                    },
                },
            }
        end
    },
    {
        'theprimeagen/harpoon',
        config = function()
            require("harpoon").setup({})
        end
    },
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
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind.nvim',
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    { "lukas-reineke/lsp-format.nvim", config = true },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 150,
                options = {
                    number = true,
                    relativenumber = false,
                }
            },
        }
    },
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
require 'lspconfig'.clangd.setup {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = function() return vim.loop.cwd() end
}

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        -- ["jdtls"] = function() end,
    },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format()
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    })
})

vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}

-- ################
-- ### Settings ###
-- ################
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.scrolloff = 20
vim.opt.wrap = false
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
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.swapfile = false

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c", "cc", "h", "hpp" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end
})

-- ##############
-- ### Remaps ###
-- ##############
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>ll", "<cmd>set background=light<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dd", "<cmd>set background=dark<cr>", { silent = true, noremap = true })

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

-- Zen mode
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
end)

-- LSP
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { noremap = true, silent = true })

-- Avante
vim.keymap.set('n', '<leader>aa', '<cmd>AvanteToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>aa', '<cmd>AvanteAsk<CR>', { noremap = true, silent = true })
