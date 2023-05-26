return {
  'nvim-pack/nvim-spectre',
  keys = {
    { '<leader>sr', function() require('spectre').open() end }
  },
  opts = {
    replace_engine = {
      ['sed'] = { cmd = 'sed', args = { "-i", "", "-E" } },
    },
  },
}
