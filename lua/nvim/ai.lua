vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

require("avante").setup({
	provider = "copilot",
	auto_suggestions_provider = "copilot",
	providers = {
		copilot = {
			model = "gpt-5",
			extra_request_body = {
				temperature = 0.2,
				max_tokens = 80000,
				top_p = 0.3,
			},
			timeout = 60000,
		},

		openrouter = {
			__inherited_from = "openai",
			endpoint = "https://openrouter.ai/api/v1",
			api_key_name = "OPENROUTER_API_KEY",
			model = "deepseek/deepseek-r1",
		},
	},

	web_search_engine = {
		provider = "searxng",
		providers = {
			searxng = {
				api_url_name = "SEARXNG_API_URL",
			},
		},
	},

	chunks = {
		max_size = 2000,
		overlap = 300,
	},
	behaviour = {
		auto_focus_sidebar = false,
		auto_suggestions = false,
		auto_suggestions_respect_ignore = false,
		auto_set_highlight_group = false,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		jump_result_buffer_on_finish = false,
		support_paste_from_clipboard = false,
		minimize_diff = true,
		enable_token_counting = true,
		use_cwd_as_project_root = false,
		auto_focus_on_diff_view = false,
		auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
		auto_check_diagnostics = true,
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

	selector = {
		provider = "telescope",
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
