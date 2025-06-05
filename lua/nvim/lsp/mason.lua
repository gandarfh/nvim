local servers = {
	"lua_ls",
	"cssls",
	"html",
	"gopls",
	"rust_analyzer",
	-- "ocamllsp",
	"clojure_lsp",
	-- "tsserver",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	-- "fsautocomplete",
	"prosemd_lsp",
	"terraformls",
	-- "hls",
	"tflint",
	"elixirls",
	-- "rescriptls",
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

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
	automatic_enable = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("nvim.lsp.handlers").on_attach,
		capabilities = require("nvim.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "nvim.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

lspconfig.terraformls.setup({})

lspconfig.elixirls.setup({})

lspconfig.somesass_ls.setup({
	filetypes = { "sass", "scss", "less", "css" },
})
