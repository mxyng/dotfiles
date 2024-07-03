return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = {
		{ '<leader>t', function() require('telescope.builtin').builtin() end, },
		{ '<leader>b', function() require('telescope.builtin').buffers() end, },
		{
			'<leader>p',
			function()
				require('telescope.builtin').find_files({
					find_command = { "rg", "--files", "--hidden", "--smart-case" },
				})
			end,
		},
		{ '<leader>a', function() require('telescope.builtin').live_grep() end },
		{ '<leader>f', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, },
		{ '<leader>j', function() require('telescope.builtin').lsp_document_symbols() end, },
		{ '<leader>l', function() require('telescope.builtin').current_buffer_fuzzy_find() end },
		{
			'gd',
			function()
				require('telescope.builtin').lsp_definitions({
					jump_type = 'never',
				})
			end,
		},
		{
			'gr',
			function()
				require('telescope.builtin').lsp_references({
					include_current_line = true,
					jump_type = 'never',
				})
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
