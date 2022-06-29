local keymap = vim.keymap

-- Open netrw
keymap.set('n', '<C-n>', '<cmd>E<cr>')

-- List buffers
keymap.set('n', '<C-l>', '<cmd>ls<cr>')

-- Resize
keymap.set('n', '<leader>+', '<cmd>resize +10<cr>')
keymap.set('n', '<leader>-', '<cmd>resize -10<cr>')

-- LSP Client Maps
-- See `:help vim.lsp.*` for documentation on any of the below functions
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>')
keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>')
keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.formatting()<cr>')
keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>')
keymap.set('n', '[n', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
keymap.set('n', ']n', '<cmd>lua vim.diagnostic.goto_next()<cr>')
keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>')

-- Telescope
keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>')
keymap.set('n', '<leader>r', '<cmd>Telescope live_grep<cr>')
keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- Trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
