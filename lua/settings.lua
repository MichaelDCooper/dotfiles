local o = vim.o
local opt = vim.opt

o.relativenumber = true
o.number = true
-- opt.cc = { 90 }
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
