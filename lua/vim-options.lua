vim.cmd('set noexpandtab')
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')
vim.cmd('set shiftwidth=4')

vim.cmd('set relativenumber')

vim.g.mapleader = ' '

-- mappings
vim.keymap.set('n', '<TAB>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<S-TAB>', '<cmd>bprevious<cr>')

