return {
	'github/copilot.vim',
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- vim.g.copilot_proxy = 'http://127.0.0.1:61107'
		-- vim.g.copilot_proxy_strict_ssl = 'v:false'
	end,
}
