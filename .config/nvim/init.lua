local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lewis6991/spellsitter.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'phaazon/hop.nvim'

Plug 'numToStr/Comment.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'nvim-lualine/lualine.nvim'
Plug "rafamadriz/neon"

vim.call('plug#end')

-- Remap leader
vim.g.mapleader = ' '

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- List mode
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

-- Split window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab
vim.opt.expandtab = true

-- Wrap
vim.opt.wrap = false

-- Search case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = 'en'

-- Clipboard
vim.opt.clipboard = 'unnamed'

-- Key map
vim.keymap.set('n', '<Leader>w', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>z', ':quit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>q', ':quitall<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>s', ':write<CR>', { noremap = true, silent = true })

-- Plugin: nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vim', 'bash', 'json', 'yaml', 'go', 'python' },
  highlight = {
    enable = true,
  },
}

-- Plugin: spellsitter
require('spellsitter').setup {
  enable = true,
}

-- Plugin: telescope
local Actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      '.git/',
      'node_modules/',
    },
    mappings = {
      i = {
        ['<Esc>'] = Actions.close
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
    grep_string = {
      only_sort_text = true,
      additional_args = function(opts)
        return { "--hidden" }
      end
    },
  },
}

vim.keymap.set('n', '<Leader>t', ':lua require("telescope.builtin").builtin()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>b', ':lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>p', ':lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>f', ':lua require("telescope.builtin").grep_string({ search="" })<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>j', ':lua require("telescope.builtin").grep_string()<CR>', { noremap = true, silent = true })

-- Plugin: hop
require('hop').setup {

}

vim.keymap.set('n', '<Leader>g', ':lua require("hop").hint_words()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>h', ':lua require("hop").hint_lines()<CR>', { noremap = true, silent = true })

-- Plugin: Comment
require('Comment').setup {
  ignore = "^$"
}

-- Plugin: indent_blankline
require('indent_blankline').setup {
    show_current_context = true,
    show_current_context_start = true,
}

-- Plugin: lualine
require('lualine').setup {
  options = {
    theme = 'neon',
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
}

-- Plugin: neon
vim.g.neon_style = "default"
vim.g.neon_italic_keyword = true
vim.g.neon_italic_function = true
vim.g.neon_transparent = true

-- FileType: go
vim.cmd([[autocmd FileType go set noexpandtab]])

-- Colorscheme
vim.cmd([[colorscheme neon]])
