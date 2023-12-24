local treesitter_options = {
	ensure_installed = { 'lua', 'javascript', 'typescript', 'rust' },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
}

local mason_options = {
	ensure_installed = { 'lua_ls', 'tsserver', 'rust_analyzer' },
}

return {
	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local configs = require('nvim-treesitter.configs')

			configs.setup(treesitter_options)
		end
	},

	-- lspconfig
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local lspconfig = require('lspconfig')

			for _, lsp in ipairs(mason_options.ensure_installed) do
				lspconfig[lsp].setup({
					on_attach = function()
						local opts = {}
						vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
						vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
						vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
						vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
						vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
						vim.keymap.set('n', '<leader>fm', function()
							vim.lsp.buf.format { async = true }
						end, opts)
					end,
				})
			end
		end,
		dependencies = {
			{
				'williamboman/mason.nvim',
				cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate' },
				config = true,
			},
			{
				'williamboman/mason-lspconfig.nvim',
				opts = mason_options,
			},
		},
	}
}
