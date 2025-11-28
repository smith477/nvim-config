return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  -- Load on Swift files OR when using any xcodebuild command
  ft = { "swift" },
  cmd = {
    "XcodebuildPicker",
    "XcodebuildBuild",
    "XcodebuildBuildRun",
    "XcodebuildTest",
    "XcodebuildSelectDevice",
    "XcodebuildSelectScheme",
    "XcodebuildSetup",
  },
  event = "VeryLazy", -- Fallback: ensure it loads even if no Swift file
  config = function()
    require("xcodebuild").setup({
      restore_on_start = true,
      auto_save = true,
      show_build_progress_bar = true,
      prepare_snapshot_test_previews = true,
      code_coverage = {
        enabled = true,
      },
      logs = {
        auto_open_on_failed_tests = true,
        auto_focus = true,
      },
    })

    local keymap = vim.keymap.set

    -- Main picker
    keymap("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Xcodebuild Actions" })

    -- Build & Run
    keymap("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build" })
    keymap("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build for Testing" })
    keymap("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run" })

    -- Testing
    keymap("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    keymap("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test Class" })
    keymap("v", "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })

    -- Logs & Coverage
    keymap("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
    keymap("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Coverage" })
    keymap("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Coverage Report" })

    -- Project settings
    keymap("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
    keymap("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
    keymap("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })

    -- Project Manager
    keymap("n", "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", { desc = "Project Manager" })

    -- Quickfix
    keymap("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
  end,
}
