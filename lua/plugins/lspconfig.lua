local treesitter_options = {
	ensure_installed = { 'lua' },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },  
}

local mason_options = {
	ensure_installed = { "lua_ls" },
}

return {
	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function () 
			local configs = require('nvim-treesitter.configs')

			configs.setup(treesitter_options)
		end
	},

	-- lspconfig
	{ 'williamboman/mason.nvim', config = true },
	{
		'williamboman/mason-lspconfig.nvim',
		opts = mason_options,
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')

			for _, lsp in ipairs(mason_options.ensure_installed) do
				lspconfig[lsp].setup({})
			end
		end,
	}
}
