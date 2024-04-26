return {
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			mappings = {
				['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%)%w%.]' },
				['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%]%w%.]' },
				['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%}%w%.]' },

				['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%w\\][^%"%w%.]', register = { cr = false } },
				["'"] = { action = 'closeopen', pair = "''", neigh_pattern = "[^%w\\][^%'%w%.]", register = { cr = false } },
				['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%w\\][^%`%w%.]', register = { cr = false } },
			},
		},
	},
	{
		'echasnovski/mini.comment',
		event = 'VeryLazy',
		opts = { options = { ignore_blank_line = true } },
	},
	{
		'echasnovski/mini.bufremove',
		event = 'VeryLazy',
		keys = {
			{ '<leader>w', function() require("mini.bufremove").delete() end },
		},
		opts = {},
	},
}
