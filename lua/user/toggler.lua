local status_ok, toggler = pcall(require, "nvim-toggler")
if not status_ok then
	return
end

toggler.setup({
	["high"] = "low",
	["light"] = "dark",
})
