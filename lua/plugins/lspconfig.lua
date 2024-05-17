local treesitter_options = {
	ensure_installed = { 'lua', 'javascript', 'typescript', 'rust', 'svelte', 'bash' },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
}

local mason_options = {
	ensure_installed = {
		'lua_ls',
		'tsserver',
		'rust_analyzer',
		'svelte'
	},
}

local mason_lsp_mapping = {
	gopls = 'gopls',
	lua_ls = 'lua-language-server',
	rust_analyzer = 'rust-analyzer',
	stylua = 'stylua',
	svelte = 'svelte-language-server',
	tsserver = 'typescript-language-server',
}

local mason_formatters = {
	ensure_installed = { 'biome', 'stylua' },
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
			local mason_registry = require('mason-registry')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			for _, lsp in ipairs(mason_options.ensure_installed) do
				if mason_registry.is_installed(mason_lsp_mapping[lsp]) then
					-- for rust use rustaceanvim instead of direct LSP
					if lsp ~= 'rust_analyzer' then
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
							capabilities = capabilities,
						})
					end

				end
			end
		end,
		dependencies = {
			{
				'williamboman/mason.nvim',
				event = { 'BufReadPre', 'BufNewFile' },
				cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate' },
				config = function()
					require('mason').setup()

					vim.api.nvim_create_user_command('MasonInstallAll', function()
						local mason_servers = {}
						for _, mason_server in ipairs(mason_options.ensure_installed) do
							table.insert(mason_servers, mason_lsp_mapping[mason_server])
						end

						vim.cmd('MasonInstall ' ..
							table.concat(mason_formatters.ensure_installed, ' ') ..
							' ' .. table.concat(mason_servers, ' '))
					end, {})
				end,
			},
		}
	},

	-- rustacean
	{
		'mrcjkb/rustaceanvim',
		version = '^4',
		ft = { 'rust' },
		opts = {
			server = {
				on_attach = function (_, bufnr)
					local opts = {}
					vim.keymap.set(
						'n',
						'<leader>ca',
						function()
							vim.cmd.RustLsp('codeAction')
						end,
						{ desc = "Code Action", buffer = bufnr }
					)
					-- vim.keymap.set(
					-- 	'n',
					-- 	'<leader>dr',
					-- 	function()
					-- 		vim.cmd.RustLsp('debuggables')
					-- 	end,
					-- 	{ desc = "Rust debuggables", buffer = bufnr }
					-- )

					-- lsp keymap
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				end,

				default_settings = {
					['rust-analyzer'] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						-- Add clippy lints for Rust.
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
		end,
	},

	-- formatter
	{
		'stevearc/conform.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			local conform = require('conform')

			conform.setup({
				formatters_by_ft = {
					lua = { 'stylua' },
					javascript = { 'biome' },
					javascriptreact = { 'biome' },
					typescript = { 'biome' },
					typescriptreact = { 'biome' },
				},
			})

			vim.keymap.set(
				{ 'n', 'v' },
				'<leader>fm',
				function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					})
				end,
				{ desc = 'Format file or range (in visual mode)' }
			)
		end,
	},
}
