local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end -- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "ahmedkhalf/project.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "tpope/vim-surround" })
  -- use({ "Olical/conjure" })
  use({ "windwp/nvim-spectre" })
  use({ "folke/flash.nvim" })

  -- Colorschemes
  use({ "gandarfh/viscond" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" })        -- The completion plugin
  use({ "hrsh7th/cmp-buffer" })      -- buffer completions
  use({ "hrsh7th/cmp-path" })        -- path completions
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lua" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" })            --snippet engine
  use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

  -- LSP
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    },
  }) -- enable LSP
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })

  use({ "nvimtools/none-ls-extras.nvim", })
  use({
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  }) -- for formatters and linters
  use({ "rescript-lang/vim-rescript" })
  -- use({ "nkrkv/nvim-treesitter-rescript" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- DAP
  use({ "nvim-neotest/nvim-nio" })
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "ravenxrz/DAPInstall.nvim" })
  use({ "leoluz/nvim-dap-go" })

  -- Frontend
  use({ "alvan/vim-closetag" })
  use({ "pangloss/vim-javascript" })
  use({ "windwp/nvim-ts-autotag" })

  -- F#
  use({ "ionide/Ionide-vim" })

  -- Elixir
  -- use({ "elixir-tools/elixir-tools.nvim", tag = "stable", requires = { "nvim-lua/plenary.nvim" } })

  -- Random
  -- use({ "github/copilot.vim" })
  use({ "norcalli/nvim-colorizer.lua" })
  -- use({
  -- 	"nvim-neorg/neorg",
  -- 	build = ":Neorg sync-parsers",
  -- })
  use({ "jbyuki/venn.nvim" })
  -- use({ "andweeb/presence.nvim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
