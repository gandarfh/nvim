-- Telescope configuration
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      local actions = require("telescope.actions")

      local function get_pickers(acts)
        return {
          find_files = {
            find_command = { "rg", "--files", "--no-ignore", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/.next/*" },
            theme = "dropdown",
            hidden = true,
          },
          live_grep = {
            hidden = true,
            only_sort_text = true,
            theme = "dropdown",
          },
          grep_string = {
            only_sort_text = true,
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
            initial_mode = "normal",
            mappings = {
              i = { ["<C-d>"] = acts.delete_buffer },
              n = { ["dd"] = acts.delete_buffer },
            },
          },
          git_files = {
            theme = "dropdown",
            hidden = true,
            previewer = false,
            show_untracked = true,
          },
          lsp_references = { theme = "dropdown", initial_mode = "normal" },
          lsp_definitions = { theme = "dropdown", initial_mode = "normal" },
          lsp_declarations = { theme = "dropdown", initial_mode = "normal" },
          lsp_implementations = { theme = "dropdown", initial_mode = "normal" },
        }
      end

      require("telescope").setup({
        pickers = get_pickers(actions),
        defaults = {
          prompt_prefix = " ",
          selection_caret = "> ",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/", "node_modules" },
          mappings = {
            i = {
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })
    end,
  },
}
