-- Colorscheme configuration
return {
  {
    "gandarfh/viscond",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme viscond]])
    end,
  },
}
