-- LSP, Mason, and null-ls configuration
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

-- LSP keymaps (buffer-local)
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<CR>', opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  vim.keymap.set("n", "<leader>lI", "<cmd>Mason<cr>", opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
end

-- on_attach callback
local function on_attach(client, bufnr)
  if client.name == "tsserver" or client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
end

return {
  -- Core dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason" },
      { "williamboman/mason-lspconfig.nvim", lazy = true },
    },
    config = function()
      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Mason setup
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
        automatic_enable = true,
      })

      -- Get capabilities from cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup each server
      for _, server in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        vim.lsp.config(server, opts)
      end

      vim.lsp.enable(servers)
    end,
  },

  -- none-ls (null-ls fork)
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvimtools/none-ls-extras.nvim", lazy = true },
    },
    config = function()
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
    end,
  },

  -- Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
