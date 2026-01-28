-- Terminal plugins configuration
return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<c-\\>", desc = "Toggle terminal" },
      { "<leader>gg", function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
        lazygit:toggle()
      end, desc = "Lazygit" },
      { "<leader>a", function()
        local Terminal = require("toggleterm.terminal").Terminal
        local httui = Terminal:new({ cmd = "httui", hidden = true })
        httui:toggle()
      end, desc = "HTTUI" },
      { "<leader>m", function()
        local Terminal = require("toggleterm.terminal").Terminal
        local glow = Terminal:new({ cmd = "glow", hidden = true })
        glow:toggle()
      end, desc = "Glow" },
    },
    opts = {
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
      float_opts = { border = "curved" },
      highlights = { FloatBorder = { guifg = "#4b5263" } },
    },
  },
}
