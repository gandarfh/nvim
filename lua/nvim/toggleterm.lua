require("toggleterm").setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
	},

	highlights = {
		FloatBorder = {
			guifg = "#4b5263",
		},
	},
})

function _G.set_terminal_keymaps() end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local httui = Terminal:new({ cmd = "httui", hidden = true })
function _HTTUI_TOGGLE()
	httui:toggle()
end

local glow = Terminal:new({ cmd = "glow", hidden = true })
function _GLOW_TOGGLE()
	glow:toggle()
end
