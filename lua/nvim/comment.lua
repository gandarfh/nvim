local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup()

vim.g.skip_ts_context_commentstring_module = true
