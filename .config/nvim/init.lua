-- Bootstrap lazy.nvim
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
    -- Colorscheme
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
                    { "fancy_cwd", substitute_home = true },
                    { "filename", path = 1 }
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
    -- Copilot for completion menu
    -- Copilot CMP source
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
        dependencies = { "zbirenbaum/copilot.lua" },
    },
    -- Testing java lsp
    { 'nvim-java/nvim-java' },
    -- Essential tools only
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    prompt_prefix = "❯ ",
                    selection_caret = "❯ ",
                    file_ignore_patterns = {
                        "node_modules", ".git/", "target/", "*.class", ".metals/", ".bloop/"
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
        dependencies = { "nvim-lua/plenary.nvim" },
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
    -- LSP stack
    { 'mason-org/mason.nvim',              version = "^1.0.0" },
    { 'mason-org/mason-lspconfig.nvim',    version = "^1.0.0" },
    { 'williamboman/mason-lspconfig.nvim', version = "^1.0.0" },
    { 'neovim/nvim-lspconfig' },
    { "lukas-reineke/lsp-format.nvim",     config = true },

    -- Minimal completion - Copilot + LSP only
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
                    -- Prioritize LSP over Copilot (lower group_index = higher priority)
                    { name = 'nvim_lsp', group_index = 1, priority = 100 },
                    { name = "copilot",  group_index = 2, priority = 50 },
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
                formatting = {
                    format = function(entry, vim_item)
                        -- Show more detailed information for LSP items
                        local kind_icons = {
                            Text = "󰉿",
                            Method = "󰆧",
                            Function = "󰊕",
                            Constructor = "",
                            Field = "󰜢",
                            Variable = "󰀫",
                            Class = "󰠱",
                            Interface = "",
                            Module = "",
                            Property = "󰜢",
                            Unit = "󰑭",
                            Value = "󰎠",
                            Enum = "",
                            Keyword = "󰌋",
                            Snippet = "",
                            Color = "󰏘",
                            File = "󰈙",
                            Reference = "󰈇",
                            Folder = "󰉋",
                            EnumMember = "",
                            Constant = "󰏿",
                            Struct = "󰙅",
                            Event = "",
                            Operator = "󰆕",
                            TypeParameter = ""
                        }

                        -- Add kind icon
                        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)

                        -- Add source name
                        vim_item.menu = ({
                            copilot = "[Copilot]",
                            nvim_lsp = "[LSP]",
                        })[entry.source.name]

                        return vim_item
                    end
                },
                experimental = { ghost_text = false },
            })

            -- Enhanced completion for JVM languages
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "java", "scala" },
                callback = function()
                    cmp.setup.buffer({
                        sources = {
                            { name = 'nvim_lsp', group_index = 1, priority = 1000 },
                            { name = "copilot",  group_index = 3, priority = 1 },
                        },
                    })
                end,
            })
        end
    },

    -- Treesitter for syntax
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'rust', 'java', 'scala', 'go', 'python', 'lua', 'c', 'cpp', 'bash', 'json', 'yaml'
                },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        ft = { "rust" },
    },
    {
        'scalameta/nvim-metals',
        ft = { "scala", "sbt" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
})

-- ################
-- ### Settings ###
-- ################
vim.g.mapleader = " "

-- Clean, terminal-like UI
vim.opt.number = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.colorcolumn = "100"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Performance for large codebases
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- No swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'

-- Terminal colors
vim.opt.termguicolors = true

-- Remaps
-- Better movement in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>r', builtin.live_grep)
vim.keymap.set('n', '<leader>b', builtin.buffers)

-- Harpoon
local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


-- LSP SETUP
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    -- Your preferred telescope-based navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)

    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, opts)

    -- Diagnostics
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[n', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']n', vim.diagnostic.goto_next, opts)
end

-- Java setup with nvim-java
require('java').setup({
    jdk = {
        auto_install = false,
    },
})

-- Enhanced jdtls configuration
local function get_jdtls_config()
    local jdtls = require('lspconfig').jdtls
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

    return {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
            'jdtls',
            '-Xmx2G',  -- Increase heap size for better performance
            '--jvm-arg=-Xms512m',
            '-data', workspace_dir,
        },
        root_dir = jdtls.document_config.default_config.root_dir,
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
                completion = {
                    favoriteStaticMembers = {
                        "org.junit.jupiter.api.Assertions.*",
                        "org.junit.Assert.*",
                        "org.mockito.Mockito.*",
                    },
                    filteredTypes = {
                        "com.sun.*",
                        "io.micrometer.shaded.*",
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
                configuration = {
                    runtimes = {},
                },
                import = {
                    gradle = {
                        enabled = true,
                    },
                    maven = {
                        enabled = true,
                    },
                },
            },
        },
        init_options = {
            bundles = {},
        },
    }
end

-- Setup jdtls with enhanced config
require('lspconfig').jdtls.setup(get_jdtls_config())

-- Mason setup with handlers to prevent double attachment
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls', 'rust_analyzer', 'gopls', 'pyright', 'clangd'
    },
    handlers = {
        function(server_name)
            -- Skip servers we handle manually
            if server_name == "rust_analyzer" then
                return
            end

            local config = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            lspconfig[server_name].setup(config)
        end,
    },
})

-- Lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Rust (disable rustaceanvim's auto-attach to prevent double setup)
vim.g.rustaceanvim = {
    server = {
        auto_attach = false,
    },
}

-- Manual Rust setup to prevent conflicts
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Go
lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- C/C++
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})


-- Enhanced Metals configuration for Scala
local metals_config = require("metals").bare_config()
metals_config.capabilities = capabilities
metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- Metals-specific commands
    vim.keymap.set("n", "<leader>mc", function()
        require("metals").commands()
    end, { buffer = bufnr, desc = "Metals commands" })

    vim.keymap.set("n", "<leader>mi", function()
        require("metals").import_build()
    end, { buffer = bufnr, desc = "Metals import build" })
end

metals_config.settings = {
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    superMethodLensesEnabled = true,
    enableSemanticHighlighting = false,

    -- Performance settings
    bloopSbtAlreadyInstalled = true,

    -- Auto-import settings
    excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
    },
}

metals_config.init_options.statusBarProvider = "on"

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
})

-- ####################
-- ### Diagnostics ###
-- ####################

-- Clean diagnostic signs (modern API)
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
