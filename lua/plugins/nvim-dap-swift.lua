return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    config = function()
      local xcodebuild = require("xcodebuild.integrations.dap")
      
      -- New API - just pass loadBreakpoints as a boolean
      xcodebuild.setup(true)  -- true means load breakpoints

      local keymap = vim.keymap.set

      -- Build & Debug
      keymap("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
      keymap("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug (no build)" })

      -- Debug tests
      keymap("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
      keymap("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Test Class" })

      -- Session control
      keymap("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Stop Debugger" })

      -- Breakpoints
      keymap("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      keymap("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Message Breakpoint" })

      -- Standard DAP controls
      local dap = require("dap")
      keymap("n", "<leader>dc", dap.continue, { desc = "Continue" })
      keymap("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      keymap("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      keymap("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require("dapui")
      dapui.setup()

      -- Auto open/close DAP UI
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Manual toggle
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },
}
