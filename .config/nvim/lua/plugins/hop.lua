return {
  'phaazon/hop.nvim',
  keys = {
    { '<leader>g', function() require('hop').hint_words() end },
    { '<leader>h', function() require('hop').hint_lines() end },
  },
  opts = {},
}
