vim.g.mapleader = ' '

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

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.linebreak = true

vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('eol:↴')

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = 'unnamed'

vim.opt.mouse = ''

vim.opt.swapfile = false

vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = 'auto'
vim.opt.foldtext = ''

-- Shada
local cwd = vim.fn.getcwd()
while cwd ~= vim.fn.expand('~') and cwd ~= "/" do
	if vim.fn.isdirectory(cwd .. '/.git') == 1 then
		vim.opt.shadafile = cwd .. '/.shada/main.shada'
		break
	end

	cwd = vim.fn.fnamemodify(cwd, ":h")
end

vim.keymap.set('n', '<c-w>t', vim.cmd.tabnew, { silent = true, noremap = true, desc = 'Create a new tab' })
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { silent = true, noremap = true, desc = 'Exit terminal mode' })

require('lazy').setup('plugins', {
	defaults = { lazy = true, version = false },
	change_detection = { enabled = false },
	rocks = { enabled = false },
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
