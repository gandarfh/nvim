local status_ok, elixir = pcall(require, "elixir")
if not status_ok then
	return
end

elixir.setup()
