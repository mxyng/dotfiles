return {
	{
		'folke/trouble.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		keys = function()
			local trouble = require("trouble")
			return {
				{ "<leader>xx", function() trouble.toggle({ mode = "diagnostics", focus = true }) end,                       desc = "Diagnostics (Trouble)" },
				{ "<leader>xX", function() trouble.toggle({ mode = "diagnostics", focus = true, filter = { buf = 0 } }) end, desc = "Buffer Diagnostics (Trouble)" },
				{ "<leader>xL", function() trouble.toggle({ mode = "loclist" }) end,                                         desc = "Location List (Trouble)" },
				{ "<leader>xQ", function() trouble.toggle({ mode = "qflist" }) end,                                          desc = "Quickfix List (Trouble)" },
			}
		end,
		opts = {
			warn_no_results = false,
			open_no_results = true,
		},
	},
	{
		'folke/todo-comments.nvim',
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local todo = require("todo-comments")
			return {
				{ "]t",         function() todo.jump_next() end, desc = "Next todo comment" },
				{ "[t",         function() todo.jump_prev() end, desc = "Previous todo comment" },
				{ "<leader>fx", "<cmd>TodoTelescope<cr>",        desc = "Telescope todo comments" },
			}
		end,
		opts = {},
	}
}
