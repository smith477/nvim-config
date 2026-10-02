-- Swift / iOS. LazyVim has no Swift extra, so this follows the same shape,
-- based on the xcodebuild.nvim author's starter config
-- (github.com/wojciech-kulik/ios-dev-starter-nvim).
--
-- First time in a project: open Neovim in the project root, then <leader>xS
-- (pick workspace, scheme, device). That also writes buildServer.json, which
-- SourceKit needs to understand Xcode/Tuist projects.
--
-- Keys
--   <leader>x…  Xcode: xb build · xr build & run · xd device · xs scheme · …
--   <leader>t…  tests, same keys as Go: tt file · tr nearest · tT all · tl last
--   <leader>d…  debug: dd build & debug · dD debug without building
--               (breakpoints, stepping etc. are LazyVim's standard dap keys)

local function cmd(c)
  return "<cmd>" .. c .. "<cr>"
end

local function dap(fn)
  return function()
    require("xcodebuild.integrations.dap")[fn]()
  end
end

return {
  -- LSP: SourceKit ships with Xcode (not installed through Mason)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = { mason = false, filetypes = { "swift" } },
      },
    },
  },

  -- Formatting: SwiftFormat on <leader>cf only, never on save
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { swift = { "swiftformat" } } },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "swift",
        callback = function()
          vim.b.autoformat = false
        end,
      })
    end,
  },

  -- Linting: SwiftLint, when it's on PATH (projects pin it with mise, so start
  -- Neovim from the project folder). Uses the project's .swiftlint.yml.
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      if vim.fn.executable("swiftlint") == 1 then
        opts.linters_by_ft = opts.linters_by_ft or {}
        opts.linters_by_ft.swift = { "swiftlint" }
      end
    end,
  },

  -- Build, run, test and debug on the simulator
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = "swift",
    cmd = { "XcodebuildSetup", "XcodebuildPicker" },
    opts = {
      show_build_progress_bar = true,
      logs = {
        auto_open_on_success_tests = false,
        auto_open_on_success_build = false,
        auto_open_on_failed_tests = true,
        auto_open_on_failed_build = true,
        auto_focus = false,
        auto_close_on_app_launch = true,
      },
      test_explorer = { auto_open = false },
      integrations = {
        -- physical devices only; needs pymobiledevice3
        pymobiledevice = { enabled = false },
        -- Tuist generates the Xcode project, so don't edit it from the file tree
        neo_tree = { enabled = false },
        nvim_tree = { enabled = false },
        oil_nvim = { enabled = false },
      },
    },
    config = function(_, opts)
      require("xcodebuild").setup(opts)
      require("xcodebuild.integrations.dap").setup() -- uses lldb-dap from Xcode
    end,
    keys = {
      { "<leader>X", cmd("XcodebuildPicker"), desc = "Xcodebuild Actions" },
      { "<leader>xS", cmd("XcodebuildSetup"), desc = "Setup Project" },
      { "<leader>xb", cmd("XcodebuildBuild"), desc = "Build" },
      { "<leader>xB", cmd("XcodebuildBuildForTesting"), desc = "Build for Testing" },
      { "<leader>xr", cmd("XcodebuildBuildRun"), desc = "Build & Run" },
      { "<leader>xk", cmd("XcodebuildCancel"), desc = "Cancel Build/Test" },
      { "<leader>xs", cmd("XcodebuildSelectScheme"), desc = "Select Scheme" },
      { "<leader>xd", cmd("XcodebuildSelectDevice"), desc = "Select Device" },
      { "<leader>xp", cmd("XcodebuildSelectTestPlan"), desc = "Select Test Plan" },
      { "<leader>xe", cmd("XcodebuildTestExplorerToggle"), desc = "Test Explorer" },
      { "<leader>xo", cmd("XcodebuildToggleLogs"), desc = "Build/Test Logs" },
      { "<leader>xc", cmd("XcodebuildToggleCodeCoverage"), desc = "Toggle Code Coverage" },
      { "<leader>xC", cmd("XcodebuildShowCodeCoverageReport"), desc = "Code Coverage Report" },
      { "<leader>xa", cmd("XcodebuildCodeActions"), desc = "Xcodebuild Code Actions" },
      { "<leader>xO", cmd("XcodebuildOpenInXcode"), desc = "Open in Xcode" },

      -- Tests: same keys as neotest (Go), but in Swift files
      { "<leader>tt", cmd("XcodebuildTestClass"), desc = "Run File/Class (Xcode)", ft = "swift" },
      { "<leader>tr", cmd("XcodebuildTestNearest"), desc = "Run Nearest (Xcode)", ft = "swift" },
      { "<leader>tr", cmd("XcodebuildTestSelected"), desc = "Run Selected (Xcode)", ft = "swift", mode = "v" },
      { "<leader>tT", cmd("XcodebuildTest"), desc = "Run All Tests (Xcode)", ft = "swift" },
      { "<leader>tl", cmd("XcodebuildTestRepeat"), desc = "Run Last (Xcode)", ft = "swift" },
      { "<leader>ts", cmd("XcodebuildTestExplorerToggle"), desc = "Test Explorer (Xcode)", ft = "swift" },
      { "<leader>to", cmd("XcodebuildToggleLogs"), desc = "Test Output (Xcode)", ft = "swift" },
      { "<leader>tS", cmd("XcodebuildCancel"), desc = "Stop (Xcode)", ft = "swift" },
      { "<leader>td", dap("debug_class_tests"), desc = "Debug Tests in File (Xcode)", ft = "swift" },

      -- Debugging: build/launch through Xcode; the rest is standard dap
      { "<leader>dd", dap("build_and_debug"), desc = "Build & Debug (Xcode)", ft = "swift" },
      { "<leader>dD", dap("debug_without_build"), desc = "Debug Without Building (Xcode)", ft = "swift" },
      { "<leader>db", dap("toggle_breakpoint"), desc = "Toggle Breakpoint (saved)", ft = "swift" },
      { "<leader>dt", dap("terminate_session"), desc = "Stop App & Debugger (Xcode)", ft = "swift" },
    },
  },
}
