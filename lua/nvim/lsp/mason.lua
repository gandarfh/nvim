local servers = {
  "lua_ls",
  "protols",
  "clangd",
  "cssls",
  "html",
  "gopls",
  "rust_analyzer",
  "clojure_lsp",
  "ts_ls",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "terraformls",
  "tflint",
  "elixirls",
  "tailwindcss",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

-- Mason config
require("mason").setup({
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
  automatic_enable = true, -- agora pode ser true
})

-- -- capabilities (de nvim-cmp)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
-- if cmp_ok then
--   capabilities = cmp_lsp.default_capabilities(capabilities)
-- end


local capabilities = require("nvim.lsp.handlers").capabilities
local on_attach = require("nvim.lsp.handlers").on_attach

-- registrar configs
for _, server in ipairs(servers) do
  local ok, conf_opts = pcall(require, "nvim.lsp.settings." .. server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if ok then
    opts = vim.tbl_deep_extend("force", opts, conf_opts)
  end

  -- nova API
  vim.lsp.config(server, opts)
end

-- habilita todos
vim.lsp.enable(servers)
