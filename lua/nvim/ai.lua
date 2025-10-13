vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })


require("mcphub").setup({
  extensions = {
    avante = {
      make_slash_commands = true,
    },
  },
})
