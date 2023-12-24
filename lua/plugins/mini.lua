return {
	-- mini.nvim
	{
		'echasnovski/mini.nvim',
		version = false
	},
	{
		'echasnovski/mini.pick',
		version = false,
		config = true,
		lazy = true,
		keys = {
			{ '<leader>ff', '<cmd>Pick files<cr>' },
			{ '<leader>fw', '<cmd>Pick grep_live<cr>' },
			{ '<leader>fb', '<cmd>Pick buffers<cr>' },
		},
	},
	{ 'echasnovski/mini.starter', version = false, config = true },
	{
		'echasnovski/mini.files',
		version = false,
		keys = function()
			local MiniFiles = require('mini.files')

			return {
				{ '<C-n>', function() MiniFiles.open() end },
			}
		end,
	},
	{
		'echasnovski/mini.statusline',
		version = false,
		config = true,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	{
		'echasnovski/mini.tabline',
		version = false,
		config = true,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	},
	{
		'echasnovski/mini.pairs',
		event = "InsertEnter",
		version = false,
		config = true,
	},
}
