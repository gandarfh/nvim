local status_ok, ionide = pcall(require, "ionide")
if not status_ok then
  return
end

ionide.setup {
  on_attach = require("nvim.lsp.handlers").on_attach,
  capabilities = require("nvim.lsp.handlers").capabilities,
}
