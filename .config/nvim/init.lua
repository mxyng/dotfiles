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
vim.opt.cursorline = true

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

-- Swap
vim.opt.swapfile = false

-- Mappings
vim.keymap.set('n', '<C-W>t', vim.cmd.tabnew, { silent = true, noremap = true, desc = 'Create a new tab' })

require('lazy').setup('plugins', {
	defaults = { lazy = true, version = false },
	git = { url_format = 'git@github.com:%s.git' },
	checker = { enabled = false, frequency = 86400 },
	change_detection = { enabled = false, notify = false },
})

local augroup = vim.api.nvim_create_augroup('User', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'go', 'lua' },
	command = 'setlocal tabstop=2 shiftwidth=2 noexpandtab',
	group = augroup,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'typescript', 'javascript', 'json', 'jsonnet' },
	command = 'setlocal tabstop=2 shiftwidth=2',
	group = augroup,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'editorconfig' },
	command = 'setlocal commentstring=#\\ %s',
	group = augroup,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'helm' },
	command = 'setlocal commentstring={{/*%s*/}}',
	group = augroup,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'markdown' },
	command = 'setlocal wrap',
	group = augroup,
})

vim.cmd.colorscheme('rose-pine')
