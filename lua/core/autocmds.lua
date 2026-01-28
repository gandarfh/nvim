-- Core autocommands for Neovim
local autocmd = vim.api.nvim_create_autocmd

-- Close certain filetypes with 'q'
autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- F# filetype detection
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.fs,*.fsx,*.fsi",
  command = [[set filetype=fsharp]],
})

-- Wrap and spell for gitcommit and markdown
autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Close NvimTree if it's the last window
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Equalize window sizes on resize
autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close command window immediately
autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd("quit")
  end,
})

-- Refresh codelens for Java
autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

-- Auto sync lazy.nvim when plugin files are saved
autocmd({ "BufWritePost" }, {
  pattern = { "*/plugins/*.lua" },
  callback = function()
    require("lazy").sync()
  end,
})
