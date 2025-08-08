require("spectre").setup({
	replace_engine = {
		["sed"] = {
			cmd = "sed",
			args = {
				"-i",
				"-E",
			},
			options = {
				["ignore-case"] = {
					value = "--ignore-case",
					icon = "[I]",
					desc = "ignore case",
				},
			},
			warn = true,
		},
	},

	default = {
		replace = {
			cmd = "sed",
		},
	},
})
