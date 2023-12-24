return {
	-- mini.nvim
	{ 'echasnovski/mini.nvim', version = false },
	{
		'echasnovski/mini.pick',
		version = false,
		config = true,
		lazy = true,
		keys = {
			{ '<leader>ff', '<cmd>Pick files<cr>' },
			{ '<leader>fw', '<cmd>Pick grep_live<cr>' },
		},
	},
	{
		'echasnovski/mini.files',
		version = false,
		config = function()
			local MiniFiles = require('mini.files')

			vim.keymap.set('n', '<C-n>', function() MiniFiles.open() end)
		end,
	},
	{
		'echasnovski/mini.statusline',
		version = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = true,
	},
	{
		'echasnovski/mini.pairs',
		version = false,
		config = true,
	},
}
