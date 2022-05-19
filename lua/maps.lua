local keymap  = vim.keymap
-- local opt = vim.opt
-- Chadtree
keymap.set('n', '<C-n>', '<cmd>CHADopen<CR>')

-- Telescope
keymap.set('n', '<Leader>f', '<cmd>Telescope find_files<CR>')
keymap.set('n', '<Leader>r', '<cmd>Telescope live_grep<CR>')
keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')
keymap.set('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>')

-- Trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {silent = true, noremap = true})
keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {silent = true, noremap = true})
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
