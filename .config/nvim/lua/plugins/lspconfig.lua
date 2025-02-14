return {
	'neovim/nvim-lspconfig',
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			-- bashls =  {},
			clangd =  {},
			gopls =   {
				settings = {
					gopls = {
						staticcheck = true,
						gofumpt = true,
					},
				},
			},
			-- jsonls =  {},
			-- lua_ls =  {},
			ruff =    {},
			pyright = {},
			-- yamlls =  {},
		},
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local buffer = args.buf
				vim.keymap.set('n', 'ef', function() vim.lsp.buf.format({ async = true }) end, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'eho', vim.lsp.buf.hover, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'ern', vim.lsp.buf.rename, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'eca', function() vim.lsp.buf.code_action({ context = { only = {'quickfix', 'source.organizeImports'} } }) end, { buffer = buffer, silent = true, noremap = true })
				vim.keymap.set('n', 'ecl', vim.lsp.codelens.run, { buffer = buffer, silent = true, noremap = true })

				vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			end,
		})

		for server, opts in pairs(opts.servers or {}) do
			require('lspconfig')[server].setup(opts)
		end
	end,
}
