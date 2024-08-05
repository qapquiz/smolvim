return {
	-- colorscheme
	-- {
	-- 	'catppuccin/nvim',
	-- 	name = 'catppuccin',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd('colorscheme catppuccin')
	-- 	end,
	-- },
	-- {
	-- 	'rebelot/kanagawa.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd('colorscheme kanagawa')
	-- 	end,
	-- },
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd('colorscheme tokyonight-night')
		end,
	},
}
