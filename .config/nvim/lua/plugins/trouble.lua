return {
	'folke/trouble.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	cmd = "Trouble",
	opts = {
		warn_no_results = false,
		open_no_results = true,
	},
	keys = function()
		local trouble = require("trouble")
		return {
			{ "<leader>xx", function() trouble.toggle({ mode = "diagnostics", focus = true }) end,                       desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", function() trouble.toggle({ mode = "diagnostics", focus = true, filter = { buf = 0 } }) end, desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xL", function() trouble.toggle({ mode = "loclist" }) end,                                         desc = "Location List (Trouble)" },
			{ "<leader>xQ", function() trouble.toggle({ mode = "qflist" }) end,                                          desc = "Quickfix List (Trouble)" },
		}
	end
}
