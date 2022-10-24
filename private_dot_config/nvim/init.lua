-- editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
-- colours
vim.opt.termguicolors = true
-- tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
-- keymaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
