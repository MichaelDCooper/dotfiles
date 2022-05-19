local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')
Plug('darrikonn/vim-gofmt', { ['do'] = ':GoUpdateBinaries' })
Plug('ms-jpq/chadtree', { branch = 'chad', ['do'] = 'python3 -m chadtree deps' })
Plug 'tpope/vim-commentary'
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
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.call('plug#end')
