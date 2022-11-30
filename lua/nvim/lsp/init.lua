local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("nvim.lsp.mason")
require("nvim.lsp.handlers").setup()
require("nvim.lsp.null-ls")
