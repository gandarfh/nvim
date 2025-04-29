local util = require 'lspconfig.util'

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.diagnostics.golangci_lint,

    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.ocamlformat,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.diagnostics.credo,

    null_ls.builtins.formatting.prettierd,
    require("none-ls.formatting.eslint_d"),
    require("none-ls.diagnostics.eslint_d"),
  },
})

require 'lspconfig'.eslint.setup {
  -- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
  root_dir = util.root_pattern(
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'eslint.config.js'
  ),
}

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
