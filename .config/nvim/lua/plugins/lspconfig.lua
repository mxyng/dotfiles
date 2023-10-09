return {
	'neovim/nvim-lspconfig',
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			pylsp = {
				cmd = { '/Users/michaelyang/Library/Caches/pypoetry/virtualenvs/local-sWZ7gQg_-py3.11/bin/pylsp' },
				settings = {
					pylsp = {
						plugins = {
							autopep8 = { enabled = false },
							pycodestyle = {
								ignore = { 'E501' },
								indentSize = 2,
							},
						},
					},
				},
			},
			clangd = {},
			gopls = {
				cmd = { '/Users/michaelyang/go/bin/gopls', 'serve' },
				filetypes = { 'go', 'gomod' },
				root_dir = function() require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git') end,
				settings = {
					gopls = {
						staticcheck = true,
						analyses = {
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							usedany = true,
							unusedvariable = true,
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						telemetry = { enable = false },
						workspace = {
							library = vim.api.nvim_get_runtime_file('', true),
							checkThirdParty = false,
						},
					},
				},
			},
		},
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local buffer = args.buf
				vim.keymap.set('n', 'ef', function() vim.lsp.buf.format({ async = true }) end, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'eho', vim.lsp.buf.hover, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'ern', vim.lsp.buf.rename, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'eca', vim.lsp.buf.code_action, { buffer = buffer, silent = true, noremap = true })

				vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			end,
		})

		for server, opts in pairs(opts.servers or {}) do
			require('lspconfig')[server].setup(opts)
		end
	end,
}
