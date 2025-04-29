local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- configs.setup({
-- 	ensure_installed = { "lua", "c", "cpp", "tsx", "markdown", "markdown_inline", "bash", "python", "clojure" }, -- put the language you want in this array
-- 	-- ensure_installed = "all", -- one of "all" or a list of languages
-- 	ignore_install = {}, -- List of parsers to ignore installing
-- 	auto_install = true,
-- 	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
-- 	highlight = {
-- 		enable = true, -- false will disable the whole extension
-- 		disable = {}, -- list of language that will be disabled
-- 	},
-- 	autopairs = {
-- 		enable = true,
-- 	},
-- 	indent = { enable = true, disable = { "python", "css" } },
-- 	context_commentstring = {
-- 		enable = true,
-- 		enable_autocmd = false,
-- 	},
-- })

-- vim.g["conjure#extract#tree_sitter#enabled"] = true

configs.setup({
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "go", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})
