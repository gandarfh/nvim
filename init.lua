-- Speed up loading Lua modules
vim.loader.enable()

-- Core settings (load immediately - minimal overhead)
require("nvim.options")
require("nvim.keymaps")
require("nvim.autocommands")

-- Plugins with lazy.nvim (handles all lazy loading)
require("nvim.plugins")
