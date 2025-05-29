return {
	'nvim-lualine/lualine.nvim',
	event = 'ColorScheme',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		options = { theme = 'auto' },
		sections = {
			lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
			lualine_c = { { 'filename', path = 1 } },
		},
		inactive_sections = {
			lualine_c = { { 'filename', path = 1 } },
		},
	},
}
