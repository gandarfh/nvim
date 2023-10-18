local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
  debug = false,
  sources = {
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.goimports,
    formatting.stylua,
    formatting.eslint_d,
    formatting.ocamlformat,
    formatting.google_java_format,
    diagnostics.flake8,
    diagnostics.eslint_d,
  },
})

-- require 'lspconfig'.eslint.setup {
--   -- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
--   root_dir = util.root_pattern(
--     '.eslintrc',
--     '.eslintrc.js',
--     '.eslintrc.cjs',
--     '.eslintrc.yaml',
--     '.eslintrc.yml',
--     '.eslintrc.json'
--   -- Disabled to prevent "No ESLint configuration found" exceptions
--   -- 'package.json',
--   ),
-- }

require 'lspconfig'.lua_ls.setup {
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
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
