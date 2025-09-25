return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.set_log_level("WARN")

		vim.api.nvim_create_user_command('LspCapabilities', function()
			local capabilities = {}
			local clients = vim.lsp.get_clients()
			for _, client in ipairs(clients) do
				capabilities[client.name] = client.server_capabilities
			end

			print(vim.inspect(capabilities))
		end, {})

		local function buf_write_pre_code_action(kind, supportedKinds)
			if supportedKinds:any(function(k) return k == kind end) then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("LspCodeAction", {}),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { kind },
							},
						})
					end,
				})
			end
		end

		for server, settings in pairs({
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
					pythonPath = '.venv/bin/python',
				},
			},
			astro = {},
			rust_analyzer = {},
			lua_ls = {},
			tailwindcss = {},
			tsgo = {},
			zls = {},
		}) do
			vim.lsp.enable(server)
			vim.lsp.config(server, {
				cmd = settings.cmd,
				settings = settings,
				on_attach = function(client, bufnr)
					if client.supports_method('textDocument/foldingRange') then
						vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
						vim.opt.foldmethod = 'expr'
					end

					local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
					if filetype ~= 'cuda' and filetype ~= 'c' and filetype ~= 'cpp' and filetype ~= 'objc' then
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_create_autocmd("BufWritePre", {
								group = vim.api.nvim_create_augroup("LspFormatting", {}),
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format()
								end,
							})
						end

						local codeActionProvider = client.server_capabilities.codeActionProvider
						if codeActionProvider then
							buf_write_pre_code_action("source.organizeImports", vim.iter(codeActionProvider.codeActionKinds))
						end
					end
				end,
			})
		end
	end,
}
