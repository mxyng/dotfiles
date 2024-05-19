return {
	'folke/trouble.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '[q', function() require('trouble').toggle('document_diagnostics') end },
		{ ']q', function() require('trouble').toggle('workspace_disagnostics') end },
	},
	opts = {},
}
