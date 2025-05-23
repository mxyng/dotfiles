return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		settings = {
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
			lua_ls = {},
		},
	},
	config = function(_, opts)
		for server, settings in pairs(opts.settings or {}) do
			vim.lsp.enable(server)
			vim.lsp.config(server, {
				settings = settings,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("LspFormatting", {}),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end

					local function enableCodeActionKind(kind, supportedKinds)
						if supportedKinds[kind] ~= nil then
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

					enableCodeActionKind("source.organizeImports", client.server_capabilities.codeActionProvider)
				end,
			})
		end
	end,
}
