return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    servers = {
      clangd = {},
      gopls = {
        cmd = { '/Users/michaelyang/go/bin/gopls', 'serve' },
        filetypes = { 'go', 'gomod' },
        root_dir = function() require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git') end,
        settings = {
          gopls = {
            staticcheck = true,
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              usedany = true,
              unusedvariable = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local buffer = args.buf
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)

        local keys = require('lazy.core.handler.keys')
        local utils = require('lazy.core.util')
        local defaults = {
          buffer = buffer,
          silent = true,
          noremap = true,
        }

        local keymaps = {
          { 'ef',  function() vim.lsp.buf.format({ async = true }) end },
          { 'eho', vim.lsp.buf.hover },
          { 'ern', vim.lsp.buf.rename },
          { 'eca', vim.lsp.buf.code_action },

          { 'ewa', vim.lsp.buf.add_workspace_folder },
          { 'ewr', vim.lsp.buf.remove_workspace_folder },
          { 'ewl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
        }

        vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        for _, keymap in pairs(keymaps) do
          local key = keys.parse(keymap)
          local opts = keys.opts(key)
          vim.keymap.set(key.mode or 'n', key[1], key[2], utils.merge(defaults, opts))
        end
      end,
    })

    for server, opts in pairs(opts.servers or {}) do
      require('lspconfig')[server].setup(opts)
    end
  end,
}
