local M = {}

-- Capabilities
local cmp_nvim_lsp = require("cmp_nvim_lsp")
M.capabilities = cmp_nvim_lsp.default_capabilities()

-- Spell checking
vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.spell = true

-- Setup de diagnósticos
M.setup = function()
	local config = {
		virtual_text = false,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

-- Keymaps
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", '<cmd>lua vim.lsp.buf.hover({border = "rounded"})<CR>', opts)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
end

-- on_attach
M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)

	local status_ok, illuminate = pcall(require, "illuminate")
	if status_ok then
		illuminate.on_attach(client)
	end
end

return M
