local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.diagnostics.golangci_lint,

    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.ocamlformat,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.diagnostics.credo,

    null_ls.builtins.formatting.prettierd,
    require("none-ls.formatting.eslint_d"),
    require("none-ls.diagnostics.eslint_d"),
  },
})

-- lua_ls config is handled by mason-lspconfig in nvim/lsp/mason.lua
