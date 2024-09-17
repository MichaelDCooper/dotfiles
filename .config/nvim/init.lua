-- ###############
-- ### Plugins ###
-- ###############
vim.api.nvim_command('echo "hi michael"')

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
                contrast = "hard", -- can be "hard", "soft" or empty string
                italic = {
                    strings = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
            })
        end
    },
    {
        "nyoom-engineering/oxocarbon.nvim"
    },
    { 'projekt0n/github-nvim-theme' },
    { "folke/tokyonight.nvim" },
    { "rose-pine/neovim",           name = "rose-pine" },
    { "xiantang/darcula-dark.nvim" },
    {
        "navarasu/onedark.nvim",
        config = function()
            require("onedark").setup {
                style = "warmer"
            }
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
                theme = "auto",
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
                    "fancy_diff",
                },
                lualine_c = {
                    "fancy_cwd",
                },
                lualine_x = {
                    "fancy_lsp_servers",
                    "fancy_diagnostics",
                    "fancy_searchcount",
                    "progress",
                },
                lualine_y = {
                    {
                        "fancy_filetype",
                        ts_icon = ""
                    },
                },
                lualine_z = {
                    "fancy_location",
                },
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
            extensions = { "neo-tree", "lazy", "trouble", "quickfix" },
        }
    },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-vinegar' },
    { 'tpope/vim-surround' },
    { 'nvim-lua/plenary.nvim' },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup {
                keywords = {
                    FIX = {
                        icon = " ",
                        color = "error",
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
            }
        end
    },
    {
        'scalameta/nvim-metals',
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt" },
                callback = function()
                    require("metals").initialize_or_attach({
                        settings = {
                            showImplicitArguments = true,
                            excludedPackages = {
                                "akka.actor.typed.javadsl",
                                "com.github.swagger.akka.javadsl",
                            },
                        },
                    })
                end,
                group = nvim_metals_group,
            })
        end
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        opts = {
            -- add any opts here
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
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
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        config = function()
            require("trouble").setup {
                position = "bottom",
                height = 10,
                width = 50,
                icons = true,
                mode = "workspace_diagnostics",
                fold_open = "",
                fold_closed = "",
                group = true,
                padding = true,
                action_keys = {
                    close = "q",
                    cancel = "<esc>",
                    refresh = "r",
                    jump = { "<cr>", "<tab>" },
                    open_split = { "<c-x>" },
                    open_vsplit = { "<c-v>" },
                    open_tab = { "<c-t>" },
                    jump_close = { "o" },
                    toggle_mode = "m",
                    toggle_preview = "P",
                    hover = "K",
                    preview = "p",
                    close_folds = { "zM", "zm" },
                    open_folds = { "zR", "zr" },
                    toggle_fold = { "zA", "za" },
                    previous = "k",
                    next = "j"
                },
            }
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
                    },
                },
            }
        end
    },
    {
        'theprimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require("harpoon").setup({
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 4,
                }
            })
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
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    { "lukas-reineke/lsp-format.nvim", config = true },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 150,
                options = {
                    number = true,
                    relativenumber = true,
                }
            },
        }
    },
})

local colorschemes = {
    rp = "rose-pine",
    tn = "tokyonight-storm",
    oxo = "oxocarbon",
    g = "gruvbox",
    gh = "github_dark_default",
    darcula = "darcula-dark",

}

local function save_colorscheme(theme)
    local file = io.open(vim.fn.stdpath("data") .. "/last_colorscheme", "w")
    if file then
        file:write(theme)
        file:close()
    end
end

local function load_last_colorscheme()
    local file = io.open(vim.fn.stdpath("data") .. "/last_colorscheme", "r")
    if file then
        local theme = file:read("*all")
        file:close()
        return theme
    end
    return nil
end

function SetColorscheme(theme)
    if colorschemes[theme] then
        theme = colorschemes[theme]
    end
    vim.cmd("colorscheme " .. theme)
    save_colorscheme(theme)
end

vim.api.nvim_create_user_command('SetColorscheme', function(opts)
    SetColorscheme(opts.args)
end, { nargs = 1 })


-- Set default colorscheme
local last_theme = load_last_colorscheme()
if last_theme then
    SetColorscheme(last_theme)
else
    SetColorscheme("gruvbox")
end

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
    ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "pyright" },
    handlers = {
        lsp_zero.default_setup,
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
    virtual_text = false,
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
vim.opt.relativenumber = false
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

-- ##############
-- ### Remaps ###
-- ##############
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>ll", "<cmd>set background=light<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>dd", "<cmd>set background=dark<cr>", { silent = true, noremap = true })

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>r', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

-- clear copy buffer
vim.keymap.set('n', '<leader>dp', "<cmd>dp+<CR>", { silent = true })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)

vim.keymap.set("n", "<leader>=", '<cmd>resize +10<cr>')
vim.keymap.set("n", "<leader>-", '<cmd>resize -10<cr>')

-- Toggle inlay hints
vim.keymap.set('n', '<leader>th', function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
end, { desc = "Toggle Inlay Hints" })

-- Zen mode
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
end)


-- LSP
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { noremap = true, silent = true })
