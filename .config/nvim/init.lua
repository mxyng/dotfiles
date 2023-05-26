local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Remap leader
vim.g.mapleader = ' '

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true

-- List mode
vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↴')

-- Split window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Wrap
vim.opt.wrap = false

-- Search case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clipboard
vim.opt.clipboard = 'unnamed'

-- Mouse
vim.opt.mouse = ''

-- Mappings
local keymaps = {
  { '<leader>z', vim.cmd.quit },
  { '<leader>q', vim.cmd.quitall },
  { '<leader>s', vim.cmd.write },

  { 'zl',        '<nop>' },
  { 'zw',        '<nop>' },
}

local keys = require('lazy.core.handler.keys')
local utils = require('lazy.core.util')
local defaults = {
  silent = true,
  noremap = true,
}

for _, keymap in pairs(keymaps) do
  local key = keys.parse(keymap)
  local opts = keys.opts(key)
  vim.keymap.set(key.mode or 'n', key[1], key[2], utils.merge(defaults, opts))
end

require('lazy').setup('plugins', {
  defaults = { lazy = true, version = false },
  git = { url_format = 'git@github.com:%s.git' },
  checker = { enabled = true, frequency = 86400 },
  change_detection = { enabled = false, notify = false },
})

local augroup = vim.api.nvim_create_augroup('User', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'lua' },
  command = 'setlocal tabstop=2 shiftwidth=2 noexpandtab',
  group = augroup
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'helm' },
  command = 'setlocal cms={{/*%s*/}}',
  group = augroup
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  command = 'setlocal wrap',
  group = augroup
})

-- colorscheme
vim.cmd.colorscheme('tokyonight')
