return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = function()
		local telescope = require("telescope.builtin")
		return {
			{ '<leader>ft', function() telescope.builtin() end,                                                                      desc = 'Telescope builtins' },
			{ '<leader>ff', function() telescope.find_files({ find_command = { "rg", "--files", "--hidden", "--smart-case" } }) end, desc = 'Telescope find files' },
			{ '<leader>fg', function() telescope.live_grep() end,                                                                    desc = 'Telescope live grep' },
			{ '<leader>fb', function() telescope.buffers() end,                                                                      desc = 'Telescope buffers' },
			{ '<leader>fl', function() telescope.current_buffer_fuzzy_find() end,                                                    desc = 'Telescope current buffer fuzzy find' },

			{ '<c-]>',      function() telescope.lsp_definitions({ jump_type = 'never' }) end,                                       desc = 'vim.lsp.buf.definition()' },
			{ 'gri',        function() telescope.lsp_implementations({ include_current_line = true, jump_type = 'never' }) end,      desc = 'vim.lsp.buf.implementation()' },
			{ 'grr',        function() telescope.lsp_references({ include_current_line = true, jump_type = 'never' }) end,           desc = 'vim.lsp.buf.references()' },
			{ 'gO',         function() telescope.lsp_document_symbols() end,                                                         desc = 'vim.lsp.buf.document_symbols()' },
			{ 'gW',         function() telescope.lsp_dynamic_workspace_symbols() end,                                                desc = 'vim.lsp.buf.workspace_symbols()' },
		}
	end,
	opts = function()
		local actions = require('telescope.actions')
		return {
			defaults = {
				mappings = {
					i = {
						['<esc>'] = actions.close,
					},
				},
			},
		}
	end,
}
