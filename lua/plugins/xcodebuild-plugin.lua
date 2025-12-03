return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "swift" },
	cmd = {
		"XcodebuildPicker",
		"XcodebuildBuild",
		"XcodebuildBuildRun",
		"XcodebuildTest",
		"XcodebuildTestExplorer",
		"XcodebuildSelectDevice",
		"XcodebuildSelectScheme",
		"XcodebuildSetup",
	},
	event = "VeryLazy",
	config = function()
		require("xcodebuild").setup({
			restore_on_start = true,
			auto_save = true,
			show_build_progress_bar = true,
			prepare_snapshot_test_previews = true,
			integrations = {
				pymobiledevice = {
					enabled = true,
				},
			},
			code_coverage = {
				enabled = true,
			},
			logs = {
				auto_open_on_success = true,
				auto_open_on_failed_tests = true,
				auto_focus = true,
				auto_close_on_success = false,
			},
		})

		local keymap = vim.keymap.set

		-- ============================================
		-- MAIN ACTIONS
		-- ============================================
		keymap("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })

		-- ============================================
		-- TESTING (MOST IMPORTANT)
		-- ============================================
		-- Test Explorer - Visual tree showing ALL tests
		keymap("n", "<leader>xe", "<cmd>XcodebuildTestExplorer<cr>", { desc = "Test Explorer (See All Tests)" })

		-- Run tests from current file
		keymap("n", "<leader>tr", "<cmd>XcodebuildTestNearest<cr>", { desc = "Run Single Test (cursor)" })
		keymap("n", "<leader>tf", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test File (all tests in file)" })
		keymap("n", "<leader>ta", "<cmd>XcodebuildTest<cr>", { desc = "Run All Tests" })
		keymap("n", "<leader>tl", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })

		-- Visual mode - select multiple tests
		keymap("v", "<leader>tr", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })

		-- ============================================
		-- LOGS & RESULTS
		-- ============================================
		keymap("n", "<leader>tL", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Test Logs" })
		keymap("n", "<leader>tc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
		keymap("n", "<leader>tC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Coverage Report" })

		-- ============================================
		-- BUILD & RUN
		-- ============================================
		keymap("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
		keymap("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build for Testing" })
		keymap("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run App" })

		-- ============================================
		-- PROJECT SETUP
		-- ============================================
		keymap("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
		keymap("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
		keymap("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
		keymap("n", "<leader>xS", "<cmd>XcodebuildSetup<cr>", { desc = "Setup Project" })
	end,
}
