local status_ok, presence = pcall(require, "presence")
if not status_ok then
	return
end

presence.setup()
