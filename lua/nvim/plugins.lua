local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.fn.isdirectory(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	-- Core dependencies
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- UI and appearance
	{ "gandarfh/viscond", lazy = true },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	-- { "akinsho/bufferline.nvim", event = "VeryLazy" },
	-- { "lukas-reineke/indent-blankline.nvim", event = "BufRead" },
	{ "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },

	-- File management
	{ "kyazdani42/nvim-tree.lua", cmd = "NvimTreeToggle" },
	{ "ahmedkhalf/project.nvim", event = "VeryLazy" },

	-- Editing enhancements
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim" },
	-- { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{ "tpope/vim-surround" },
	{ "windwp/nvim-spectre", cmd = "Spectre" },
	-- { "moll/vim-bbye", cmd = "Bdelete" },

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim", cmd = "Telescope" },

	-- LSP and completion
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", cmd = "Mason" },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{ "nvimtools/none-ls.nvim" },
	{ "nvimtools/none-ls-extras.nvim", lazy = true },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer", lazy = true },
			{ "hrsh7th/cmp-path", lazy = true },
			{ "hrsh7th/cmp-nvim-lsp", lazy = true },
			{ "hrsh7th/cmp-nvim-lua", lazy = true },
			{ "saadparwaiz1/cmp_luasnip", lazy = true },
		},
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			{ "rafamadriz/friendly-snippets", lazy = true },
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
	},

	-- Git
	{ "lewis6991/gitsigns.nvim", event = "BufRead" },

	-- DAP
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"ravenxrz/DAPInstall.nvim",
			"leoluz/nvim-dap-go",
		},
	},

	-- Terminal
	{ "akinsho/toggleterm.nvim", cmd = "ToggleTerm" },

	-- Language specific
	{ "windwp/nvim-ts-autotag" },
	{ "alvan/vim-closetag" },
	{ "pangloss/vim-javascript" },
	-- {
	-- 	"ionide/Ionide-vim",
	-- 	ft = "fsharp",
	-- 	enabled = function()
	-- 		return vim.fn.executable("dotnet") == 1
	-- 	end
	-- },

	-- AI tools
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"HakonHarnes/img-clip.nvim",
		},
	},

	-- Utilities
	{ "jbyuki/venn.nvim", cmd = "VBox" },
}, {
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
