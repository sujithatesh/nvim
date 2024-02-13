vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- WTF is this 
vim.keymap.set({ 'i', 'n', 'v' }, '<C-c>', '<Esc>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

----------------------------------------------------------------------------------------------------------------
-- Terminal mode mappings
vim.keymap.set('n', '<leader>t', ':lua ToggleTerminal()<CR>', {noremap = true})
--
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true})

-- Insert mode mappings
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true})

-- Normal mode mappings
vim.keymap.set('n', '<A-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<A-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<A-l>', '<C-w>l', {noremap = true})
----------------------------------------------------------------------------------------------------------------
