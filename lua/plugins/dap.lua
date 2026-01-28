-- DAP (Debug Adapter Protocol) configuration
return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
    },
    dependencies = {
      { "nvim-neotest/nvim-nio", lazy = true },
      { "rcarriga/nvim-dap-ui", lazy = true },
      { "ravenxrz/DAPInstall.nvim", lazy = true },
      { "leoluz/nvim-dap-go", lazy = true },
    },
    config = function()
      local dap = require("dap")

      require("dap-install").setup({})
      require("dap-install").config("python", {})

      require("dap-go").setup({
        dap_configurations = {},
        delve = {
          path = "dlv",
          port = "${port}",
          args = {},
          build_flags = {},
          detached = true,
          cwd = nil,
        },
        tests = { verbose = false },
      })

      require("dapui").setup({
        expand_lines = true,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.20,
            position = "right",
          },
          {
            elements = { { id = "repl", size = 1.00 } },
            size = 0.25,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.25,
          max_width = 0.5,
          border = vim.g.rounded,
          mappings = { close = { "q", "<Esc>" } },
        },
      })

      -- Go configurations
      dap.configurations.go = {
        { type = "go", name = "Attach remote", mode = "remote", request = "attach", port = "2345" },
        { type = "go", name = "Debug", request = "launch", program = "${file}" },
        { type = "go", name = "Debug test", request = "launch", mode = "test", program = "./${relativeFileDirname}", logOutput = "dap", showLog = true },
        { type = "go", name = "Debug test (go.mod)", request = "launch", mode = "test", program = "./${relativeFileDirname}" },
      }

      -- JavaScript/TypeScript configurations
      dap.configurations.javascript = {
        { name = "Launch", type = "node2", request = "launch", program = "${file}", cwd = vim.fn.getcwd(), sourceMaps = true, protocol = "inspector", console = "integratedTerminal" },
        { name = "Attach to process", type = "node2", request = "attach", processId = require("dap.utils").pick_process },
      }

      dap.configurations.typescript = dap.configurations.javascript

      -- Signs
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
  },
}
