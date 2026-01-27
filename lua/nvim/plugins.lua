-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  -- ============================================================
  -- CORE DEPENDENCIES (lazy loaded when needed)
  -- ============================================================
  { "nvim-lua/plenary.nvim", lazy = true },
  { "kyazdani42/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  -- ============================================================
  -- COLORSCHEME (loads first, required for UI)
  -- ============================================================
  {
    "gandarfh/viscond",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme viscond]])
    end,
  },

  -- ============================================================
  -- TREESITTER (loads on first buffer read)
  -- ============================================================
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

  -- ============================================================
  -- LSP & MASON (loads on first buffer)
  -- ============================================================
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", cmd = "Mason" },
      { "williamboman/mason-lspconfig.nvim", lazy = true },
    },
    config = function()
      require("nvim.lsp")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvimtools/none-ls-extras.nvim", lazy = true },
    },
    config = function()
      require("nvim.lsp.null-ls")
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- ============================================================
  -- COMPLETION (loads on InsertEnter)
  -- ============================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-nvim-lua", lazy = true },
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      require("nvim.cmp")
    end,
  },

  -- ============================================================
  -- UI COMPONENTS (VeryLazy - after first screen draw)
  -- ============================================================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("nvim.lualine")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ============================================================
  -- FILE MANAGEMENT (loads on command)
  -- ============================================================
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    config = function()
      require("nvim.nvim-tree")
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("nvim.project")
    end,
  },

  -- ============================================================
  -- EDITING ENHANCEMENTS (loads on first buffer or InsertEnter)
  -- ============================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim.autopairs")
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle block" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "tpope/vim-surround",
    keys = { "cs", "ds", "ys", "yss", "yS", "ySS", { "S", mode = "v" }, { "gS", mode = "v" } },
  },

  {
    "windwp/nvim-spectre",
    cmd = "Spectre",
    config = function()
      require("nvim.spectre")
    end,
  },

  -- ============================================================
  -- FUZZY FINDER (loads on command)
  -- ============================================================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("nvim.telescope")
    end,
  },

  -- ============================================================
  -- GIT (loads on first buffer read)
  -- ============================================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim.gitsigns")
    end,
  },

  -- ============================================================
  -- DAP - Debugging (loads only on command)
  -- ============================================================
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    keys = {
      { "<leader>d", desc = "Debug" },
    },
    dependencies = {
      { "nvim-neotest/nvim-nio", lazy = true },
      { "rcarriga/nvim-dap-ui", lazy = true },
      { "ravenxrz/DAPInstall.nvim", lazy = true },
      { "leoluz/nvim-dap-go", lazy = true },
    },
    config = function()
      require("nvim.dap")
    end,
  },

  -- ============================================================
  -- TERMINAL (loads on command or keys)
  -- ============================================================
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<c-\\>", desc = "Toggle terminal" },
      { "<leader>gg", function() require("nvim.toggleterm"); _LAZYGIT_TOGGLE() end, desc = "Lazygit" },
      { "<leader>a", function() require("nvim.toggleterm"); _HTTUI_TOGGLE() end, desc = "HTTUI" },
      { "<leader>m", function() require("nvim.toggleterm"); _GLOW_TOGGLE() end, desc = "Glow" },
    },
    config = function()
      require("nvim.toggleterm")
    end,
  },

  -- ============================================================
  -- LANGUAGE SPECIFIC (loads on filetypes)
  -- ============================================================
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml", "php", "markdown", "astro", "handlebars" },
    config = function()
      require("nvim.autotag")
    end,
  },

  -- REMOVED: vim-closetag (redundant with nvim-ts-autotag)
  -- REMOVED: vim-javascript (treesitter handles this)

  -- ============================================================
  -- AI tools (loads on InsertEnter or keys)
  -- ============================================================
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
    end,
  },

  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<tab>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      { "<c-.>", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle", mode = { "n", "t", "i", "x" } },
      { "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
      { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select CLI" },
      { "<leader>ad", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session" },
      { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This" },
      { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
      { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "Send Visual Selection" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },
      { "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Sidekick Toggle Claude" },
    },
    opts = {},
  },

  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
  },

  -- ============================================================
  -- UTILITIES (loads on command)
  -- ============================================================
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    config = function()
      require("nvim.venn")
    end,
  },
}, {
  -- Lazy.nvim performance options
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    size = {
      width = 0.8,
      height = 0.8,
    },
    wrap = true,
    title_pos = "center",
    backdrop = 60,
  },
})
