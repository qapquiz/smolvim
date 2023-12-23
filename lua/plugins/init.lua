local M = {
	{ 
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function()
			require('catppuccin').setup()

			vim.cmd('colorscheme catppuccin')
		end,
	},
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
			MiniFiles.setup()

			vim.keymap.set('n', '<C-n>', function() MiniFiles.open() end)
		end,
	},

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function () 
		  local configs = require('nvim-treesitter.configs')

		  configs.setup({
			  ensure_installed = { 'lua' },
			  sync_install = false,
			  highlight = { enable = true },
			  indent = { enable = true },  
			})
		end
	}
}

return M
