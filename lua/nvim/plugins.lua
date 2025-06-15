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
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "kyazdani42/nvim-tree.lua" },
	{ "akinsho/bufferline.nvim" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/toggleterm.nvim" },
	{ "ahmedkhalf/project.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "tpope/vim-surround" },
	{ "windwp/nvim-spectre" },

	-- Colorschemes
	{ "gandarfh/viscond" },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{ "nvimtools/none-ls-extras.nvim" },
	{ "nvimtools/none-ls.nvim" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
	},

	-- Git
	{ "lewis6991/gitsigns.nvim" },

	-- DAP
	{ "nvim-neotest/nvim-nio" },
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "ravenxrz/DAPInstall.nvim" },
	{ "leoluz/nvim-dap-go" },

	-- Frontend
	{ "alvan/vim-closetag" },
	{ "pangloss/vim-javascript" },
	{ "windwp/nvim-ts-autotag" },

	-- F#
	{ "ionide/Ionide-vim" },

	-- AI with avante + copilot
	{ "github/copilot.vim" },
	{ "MunifTanjim/nui.nvim" },
	{ "HakonHarnes/img-clip.nvim" },
	{ "zbirenbaum/copilot.lua" },
	{
		"yetone/avante.nvim",
		-- event = "VeryLazy",
		-- opts = {},
		build = "make",
		branch = "main",
	},

	-- Random
	{ "norcalli/nvim-colorizer.lua" },
	{ "jbyuki/venn.nvim" },
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
