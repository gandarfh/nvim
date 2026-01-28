-- Core options for Neovim
local opt = vim.opt

opt.backup = false
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.fileencoding = "utf-8"
opt.hlsearch = true
opt.ignorecase = true
opt.mouse = "a"
opt.pumheight = 10
opt.showmode = false
opt.showtabline = 0
opt.smartcase = true
opt.relativenumber = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.termguicolors = true
opt.timeoutlen = 1000
opt.undofile = true
opt.updatetime = 300
opt.writebackup = false
opt.expandtab = true
opt.shiftwidth = 2
opt.guicursor = "i:block"
opt.tabstop = 2
opt.cursorline = true
opt.number = true
opt.laststatus = 3
opt.showcmd = false
opt.ruler = false
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.guifont = "monospace:h17"
opt.fillchars.eob = " "
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
opt.formatoptions:remove({ "c", "r", "o" })
opt.linebreak = true
