local util = require("lspconfig.util")

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

-- Novo estilo de configuração para lua_ls
vim.lsp.config["lua_ls"] = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.lsp.start(vim.lsp.config["lua_ls"])

-- Exemplo se quiser restaurar eslint manualmente no novo padrão
-- vim.lsp.config["eslint"] = {
--   root_dir = util.root_pattern(
--     ".eslintrc",
--     ".eslintrc.js",
--     ".eslintrc.cjs",
--     ".eslintrc.yaml",
--     ".eslintrc.yml",
--     ".eslintrc.json",
--     "eslint.config.js"
--   ),
-- }
-- vim.lsp.start(vim.lsp.config["eslint"])
