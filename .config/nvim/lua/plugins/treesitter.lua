return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ":TSUpdate",
		opts = {
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
		config = function(_, opts)
			require('nvim-treesitter').install(opts)
			vim.api.nvim_create_autocmd('FileType', {
				pattern = opts,
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.opt.foldmethod = "expr"
				end,
			})
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
