require("ionide").setup({
	on_attach = require("nvim.lsp.handlers").on_attach,
	capabilities = require("nvim.lsp.handlers").capabilities,
})
