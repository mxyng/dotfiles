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
}
