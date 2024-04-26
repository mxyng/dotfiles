return {
	'folke/trouble.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '[q', '<cmd>TroubleToggle document_diagnostics<cr>' },
		{ ']q', '<cmd>TroubleToggle workspace_diagnostics<cr>' },
		{ '[d', function()
			local trouble = require('trouble')
			if trouble.is_open() then
				trouble.next({ skip_groups = true, jump = true })
			else
				vim.diagnostic.goto_next()
			end
		end },
		{ ']d', function()
			local trouble = require('trouble')
			if trouble.is_open() then
				trouble.previous({ skip_groups = true, jump = true })
			else
				vim.diagnostic.goto_prev()
			end
		end },
	},
	opts = {},
}
