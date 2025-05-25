return {
	'folke/flash.nvim',
	event = 'VeryLazy',
	opts = {
		modes = {
			search = {
				enabled = true,
				highlight = { backdrop = true },
			},
		},
	},
	keys = function()
		local flash = require("flash")
		return {
			{ "s",     mode = { "n", "x", "o" }, function() flash.jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() flash.treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = { "o" },           function() flash.remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() flash.treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() flash.toggle() end,            desc = "Toggle Flash Search" },
		}
	end,
}
