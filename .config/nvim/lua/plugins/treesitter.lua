return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = true,
			indent = true,
			ensure_installed = {
				'vim',
				'bash',
				'json',
				'yaml',
				'c',
				'go',
				'python',
				'javascript',
				'typescript',
				'make',
				'dockerfile',
				'lua',
			},
		},
		config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	}
}
