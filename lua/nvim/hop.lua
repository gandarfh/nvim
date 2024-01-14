local status_ok, flash = pcall(require, "flash")
if not status_ok then
	return
end

local keymap = vim.keymap.set

keymap("n", "s", function()
	flash.jump()
end)
keymap("n", "S", function()
	flash.treesitter()
end)
keymap("n", "r", function()
	flash.remote()
end)
keymap("n", "R", function()
	flash.treesitter_search()
end)
keymap("n", "<c-s>", function()
	flash.toggle()
end)
