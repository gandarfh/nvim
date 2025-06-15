require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
		["core.concealer"] = {}, -- Adds pretty icons to your documents
		["core.dirman"] = { -- Manages Neorg workspaces
			config = {
				workspaces = {
					diaro = "~/diaro",
					notes = "~/notes/all",
					housi = "~/notes/housi",
				},
			},
		},
	},
})
