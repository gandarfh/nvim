-- UI plugins configuration
local lualine_colors = {
  bg = "#090909",
  gray = "#1a1a1a",
  lightgray = "#1a1a1a",
  purple = "#bd93f9",
  green = "#50fa7b",
  white = "#f8f8f2",
  black = "#282a36",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      require("lualine").setup({
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = {
            normal = {
              a = { bg = lualine_colors.yellow, fg = lualine_colors.black, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
            insert = {
              a = { bg = lualine_colors.green, fg = lualine_colors.black, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
            visual = {
              a = { bg = lualine_colors.yellow, fg = lualine_colors.black, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
            replace = {
              a = { bg = lualine_colors.red, fg = lualine_colors.black, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
            command = {
              a = { bg = lualine_colors.orange, fg = lualine_colors.black, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
            inactive = {
              a = { bg = lualine_colors.gray, fg = lualine_colors.white, gui = "bold" },
              b = { bg = lualine_colors.lightgray, fg = lualine_colors.white },
              c = { bg = lualine_colors.bg, fg = lualine_colors.white },
            },
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha", "dashboard" },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn" },
              symbols = { error = " ", warn = " " },
              colored = false,
              always_visible = true,
            },
          },
          lualine_x = {
            { "diff", colored = false, symbols = { added = " ", modified = " ", removed = " " }, cond = hide_in_width },
            function() return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") end,
            "encoding",
            { "filetype", icons_enabled = false },
          },
          lualine_y = { { "location", padding = 0 } },
          lualine_z = { "progress" },
        },
      })
    end,
  },

  -- File tree
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
        vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
        vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
        vim.keymap.set("n", "a", api.fs.create, opts("Create"))
        vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
        vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
        vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
        vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
        vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
        vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
      end

      require("nvim-tree").setup({
        update_focused_file = { enable = true, update_cwd = true },
        renderer = {
          root_folder_modifier = ":t",
          icons = { show = { folder = false, file = false, folder_arrow = false } },
        },
        git = { enable = true, ignore = false, timeout = 400 },
        diagnostics = { enable = false },
        filters = { dotfiles = false },
        view = { width = 30, side = "left" },
        on_attach = on_attach,
      })
    end,
  },

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    opts = {},
  },

  -- Venn (diagrams)
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    config = function()
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd([[setlocal ve=all]])
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
          vim.cmd([[setlocal ve=]])
          vim.cmd([[mapclear <buffer>]])
          vim.b.venn_enabled = nil
        end
      end
    end,
  },
}
