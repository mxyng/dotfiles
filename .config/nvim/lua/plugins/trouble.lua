return {
	'folke/trouble.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	cmd = "Trouble",
	opts = {
		warn_no_results = false,
		open_no_results = true,
	},
	keys = {
		{ "<leader>xx", function() require("trouble").toggle({ mode = "diagnostics", focus = true }) end, desc = 'Toggle diagnotics' },
		{
			"<leader>xX",
			function()
				trouble = require("trouble")
				opts = { mode = "diagnostics", focus = true, filter = { buf = 0 } }
				if trouble.is_open() then
					trouble.filter(opts)
				else
					trouble.open(opts)
				end
			end,
			desc = 'Toggle diagnostics for current buffer',
		},
	},
}
