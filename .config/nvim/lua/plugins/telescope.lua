return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '<leader>t', function() require('telescope.builtin').builtin() end, desc = 'Builtins' },
		{ '<leader>b', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
		{
			'<leader>p',
			function()
				require('telescope.builtin').find_files({
					find_command = { "rg", "--files", "--hidden", "--smart-case" },
				})
			end,
			desc = 'Find files',
		},
		{ '<leader>a', function() require('telescope.builtin').live_grep() end,                 desc = 'Live grep' },
		{ '<leader>l', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Fuzzy find for current buffer' },
		{
			'gri',
			function()
				require('telescope.builtin').lsp_implementations({
					include_current_line = true,
					jump_type = 'never',
				})
			end,
		},
		{
			'grr',
			function()
				require('telescope.builtin').lsp_references({
					include_current_line = true,
					jump_type = 'never',
				})
			end,
		},
		{
			'gO',
			function()
				require('telescope.builtin').lsp_document_symbols()
			end,
		},
	},
	opts = function()
		local Actions = require('telescope.actions')
		return {
			defaults = {
				mappings = {
					i = {
						['<esc>'] = Actions.close
					},
				},
			},
		}
	end,
}
