return {
	'neovim/nvim-lspconfig',
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			clangd = {},
			gopls = {
				gopls = {
					staticcheck = true,
					gofumpt = true,
				},
			},
			ruff = {},
			pyright = {
				python = {
					pythonPath = ".venv/bin/python",
				}
			},
			astro = {},
			rust_analyzer = {},
		},
	},
	config = function(_, opts)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end

			vim.lsp.completion.enable(true, client.id, bufnr, {
				autotrigger = true,
				convert = function(item)
					return { abbr = item.label:gsub('%b()', '') }
				end,
			})
		end

		for server, settings in pairs(opts.servers or {}) do
			vim.lsp.enable(server)
			vim.lsp.config(server, {
				settings = settings,
				on_attach = on_attach,
			})
		end
	end,
}
