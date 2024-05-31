local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = false,
}

local location = {
	"location",
	padding = 0,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local colors = {
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

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = {
			normal = {
				a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
			},
			insert = {
				a = { bg = colors.green, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
			},
			visual = {
				a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
			},
			replace = {
				a = { bg = colors.red, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
			},
			command = {
				a = { bg = colors.orange, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
			},
			inactive = {
				a = { bg = colors.gray, fg = colors.white, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.bg, fg = colors.white },
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
		lualine_c = { diagnostics },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})
