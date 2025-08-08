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
	{
		"MunifTanjim/nui.nvim",
	},

	-- {
	-- 	name = "httui-editor",
	-- 	dir = "~/gandarfh/httui-editor.nvim",
	-- 	config = function()
	-- 		require("httui-editor").setup({})
	-- 	end,
	-- },

	-- Core dependencies
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- UI and appearance
	{ "gandarfh/viscond", lazy = true },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	{ "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },

	-- File management
	{ "kyazdani42/nvim-tree.lua", cmd = "NvimTreeToggle" },
	{ "ahmedkhalf/project.nvim", event = "VeryLazy" },

	-- Editing enhancements
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim" },
	{ "tpope/vim-surround" },
	{ "windwp/nvim-spectre", cmd = "Spectre" },

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
		branch = "master",
		lazy = false,
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
