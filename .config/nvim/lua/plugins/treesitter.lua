return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require('nvim-treesitter.configs').setup({
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					'vim',
					'bash',
					'json',
					'yaml',
					'toml',
					'c',
					'go',
					'gotmpl',
					'python',
					'javascript',
					'typescript',
					'make',
					'dockerfile',
					'lua',
					'rust',
					'astro',
					'zig',
				},
			})

			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldmethod = "expr"
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
	},
}
