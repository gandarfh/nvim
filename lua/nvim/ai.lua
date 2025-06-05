vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

require("avante").setup({
	provider = "copilot",
	auto_suggestions_provider = "copilot",
	copilot = {
		model = "claude-sonnet-4",
		temperature = 0,
		max_tokens = 2000,
		top_p = 1.0,
		timeout = 60000,
	},
	chunks = {
		max_size = 2000,
		overlap = 200,
	},

	windows = {
		edit = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			start_insert = false,
		},
		ask = {
			floating = false,
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			start_insert = false,
			focus_on_apply = "ours",
		},
	},

	system_prompt = [[
You are a concise and precise coding copilot.
1. Always answer in Brazilian Portuguese.
2. Write all code in English.
3. Do not add comments in the code unless explicitly requested.
4. Explanations must be direct—no fluff.
5. Git commits must follow Conventional Commits in English with short messages (e.g., "feat(parser): add JSON support").
6. Keep responses tightly scoped to the context.
]],
})
