local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'lewis6991/spellsitter.nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'phaazon/hop.nvim'
Plug 'windwp/nvim-autopairs'

Plug 'numToStr/Comment.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'arcticicestudio/nord-vim'

vim.call('plug#end')

-- Remap leader
vim.g.mapleader = ' '

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true

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

-- Mouse
vim.opt.mouse = ''

-- Mappings
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<Leader>w', ':bdelete<CR>', opts)
vim.keymap.set('n', '<Leader>w', function() vim.cmd.bdelete() end, opts)
vim.keymap.set('n', '<Leader>z', function() vim.cmd.quit() end, opts)
vim.keymap.set('n', '<Leader>q', function() vim.cmd.quitall() end, opts)
vim.keymap.set('n', '<Leader>s', function() vim.cmd.write() end, opts)
vim.keymap.set('n', '<Leader>r', function() vim.cmd.edit({ bang = true }) end, opts)

vim.keymap.set('n', 'zl', '<Nop>')
vim.keymap.set('n', 'zw', '<Nop>')

-- Plugin: nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vim', 'bash', 'json', 'yaml', 'go', 'python', 'dockerfile', 'hcl', 'javascript', 'make',
    'markdown', 'sql', 'typescript' },
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
    mappings = {
      i = {
        ['<Esc>'] = Actions.close
      },
    },
  },
}

vim.keymap.set('n', '<Leader>t', require("telescope.builtin").builtin, opts)
vim.keymap.set('n', '<Leader>b', require("telescope.builtin").buffers, opts)
vim.keymap.set('n', '<Leader>p', function()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--glob=!**/.git/*",
      "--glob=!**/node_modules/*",
      "--no-ignore",
      "--smart-case",
    },
  }
end, opts)

vim.keymap.set('n', '<Leader>l', require('telescope.builtin').lsp_document_symbols, opts)
vim.keymap.set('n', '<Leader>f', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
vim.keymap.set('n', '<Leader>j', function()
  require('telescope.builtin').lsp_references {
    include_current_line = true,
    jump_type = 'never',
  }
end, opts)

-- Plugin: hop
require('hop').setup {

}

vim.keymap.set('n', '<Leader>g', require("hop").hint_words, opts)
vim.keymap.set('n', '<Leader>h', require("hop").hint_lines, opts)

-- Plugin: comment
require('comment').setup {
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
    theme = 'nord',
  },
  sections = {
    lualine_c = {
      {
        'filename', path = 1
      },
    }
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename', path = 1
      },
    }
  },
}

-- Plugin: autopairs
require('nvim-autopairs').setup {
  check_ts = true,
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
}

-- Plugin: lspconfig
vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '[q', vim.diagnostic.open_float, opts)
vim.keymap.set('n', ']q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

  vim.keymap.set('n', 'ef', function() vim.lsp.buf.format({ async = true }) end, bufopts)
  vim.keymap.set('n', 'eho', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'ern', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'eca', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', 'ewa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', 'ewr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'ewl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
end

require('lspconfig').clangd.setup {
  on_attach = on_attach,
}

require('lspconfig').gopls.setup {
  on_attach = on_attach,
  cmd = { "/Users/michaelyang/go/bin/gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig').terraformls.setup {
  on_attach = on_attach,
}

require('lspconfig').sourcekit.setup {
  on_attach = on_attach,
  cmd = { "sourcekit-lsp" },
  root_dir = require('lspconfig/util').root_pattern("Package.swift", ".git"),
}

local augroup = vim.api.nvim_create_augroup('augroup', { clear = true })

-- FileType: go
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  command = 'setlocal noexpandtab',
  group = augroup,
})

-- FileType: helm
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'helm' },
  command = 'setlocal cms={{/*%s*/}}',
  group = augroup,
})

-- FileType: markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  command = 'setlocal wrap',
  group = augroup,
})

-- colorscheme
vim.cmd.colorscheme('nord')
