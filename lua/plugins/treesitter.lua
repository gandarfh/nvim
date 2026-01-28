-- Treesitter configuration
local autotag_filetypes = {
  "html", "javascript", "typescript", "javascriptreact", "typescriptreact",
  "svelte", "vue", "tsx", "jsx", "xml", "php", "markdown", "astro", "handlebars",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "go", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        ignore_install = { "javascript" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = autotag_filetypes,
    config = function()
      require("nvim-ts-autotag").setup({
        autotag = {
          enable = true,
          filetypes = autotag_filetypes,
          skip_tags = {
            "area", "base", "br", "col", "command", "embed", "hr", "img",
            "slot", "input", "keygen", "link", "meta", "param", "source",
            "track", "wbr", "menuitem",
          },
        },
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = { spacing = 5 },
        update_in_insert = true,
      })
    end,
  },
}
