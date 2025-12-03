return {
	"nvim-mini/mini.icons", -- this one is actually fine, just needs mini.nvim awareness
	opts = {
		file = {
			[".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
		},
		filetype = {
			gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
		},
	},
}

