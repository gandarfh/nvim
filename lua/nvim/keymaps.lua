-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- -- Better paste
-- keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Formatting
function Format_range_operator()
	local old_func = vim.go.operatorfunc
	_G.op_func_formatting = function()
		local opts = {
			range = {
				["start"] = vim.api.nvim_buf_get_mark(0, "["),
				["end"] = vim.api.nvim_buf_get_mark(0, "]"),
			},
		}
		vim.lsp.buf.format(opts)
		vim.go.operatorfunc = old_func
		_G.op_func_formatting = nil
	end
	vim.go.operatorfunc = "v:lua.op_func_formatting"
	vim.api.nvim_feedkeys("g@", "n", false)
end

keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", opts)
keymap("v", "<leader>lf", "<cmd>lua Format_range_operator()<CR>", opts)

-- Plugins --
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>st", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>sb", ":Telescope buffers<CR>", opts)

-- ToggleTerm
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>a", "<cmd>lua _HTTUI_TOGGLE()<CR>", opts)
keymap("n", "<leader>m", "<cmd>lua _GLOW_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
local function open_repl_with_height()
	-- Abre ou alterna o REPL
	require("dap").repl.toggle()

	-- Ajusta a altura do REPL
	local repl_win = vim.fn.bufwinid("dap-repl")
	if repl_win ~= -1 then
		vim.api.nvim_win_set_height(repl_win, 15) -- Ajuste a altura conforme necessário
	end
end

keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>dr", open_repl_with_height, opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dk", "<cmd>lua require('dap.ui.widgets').hover()<cr>", opts)

-- toggle keymappings for venn using <leader>v
keymap("n", "<leader>v", "<cmd>lua Toggle_venn()<CR><cr>", opts)

-- Find Replace
keymap("n", "<leader>r", "<cmd>lua require('spectre').open()<cr>", opts)
