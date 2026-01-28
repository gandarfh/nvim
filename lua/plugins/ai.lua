-- AI plugins configuration
return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
    end,
  },

  -- Sidekick (Claude/AI CLI integration)
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<tab>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      { "<c-.>", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle", mode = { "n", "t", "i", "x" } },
      { "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
      { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select CLI" },
      { "<leader>ad", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session" },
      { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This" },
      { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Send File" },
      { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "Send Visual Selection" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },
      { "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Sidekick Toggle Claude" },
    },
    opts = {},
  },

  -- MCP Hub
  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    opts = {},
  },
}
