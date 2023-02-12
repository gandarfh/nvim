require("nvim.impatient")
require("nvim.options")
require("nvim.keymaps")
require("nvim.plugins")
require("nvim.autocommands")
require("nvim.colorscheme")
require("nvim.colorizer")
require("nvim.cmp")
require("nvim.telescope")
require("nvim.gitsigns")
require("nvim.treesitter")
require("nvim.autopairs")
require("nvim.comment")
require("nvim.nvim-tree")
require("nvim.lualine")
require("nvim.toggleterm")
require("nvim.project")
require("nvim.indentline")
require("nvim.lsp")
require("nvim.dap")
require("nvim.venn")
require("nvim.presence")

require("impulse").setup({})

local filetypes = {
	"html",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"tsx",
	"jsx",
	"rescript",
	"xml",
	"php",
	"markdown",
	"glimmer",
	"handlebars",
	"hbs",
}
local skip_tags = {
	"area",
	"base",
	"br",
	"col",
	"command",
	"embed",
	"hr",
	"img",
	"slot",
	"input",
	"keygen",
	"link",
	"meta",
	"param",
	"source",
	"track",
	"wbr",
	"menuitem",
}

require("nvim-ts-autotag").setup({
	autotag = {
		enable = true,
	},
	skip_tags = skip_tags,
	filetypes = filetypes,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})
