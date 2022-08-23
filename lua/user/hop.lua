local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

hop.setup({
	keys = "etovxqpdygfblzhckisuran",
})

vim.cmd("hi HopNextKey guifg=#ff9900")
vim.cmd("hi HopNextKey1 guifg=#ff9900")
vim.cmd("hi HopNextKey2 guifg=#ff9900")

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "s", ":HopWord<CR>", opts)
vim.api.nvim_set_keymap("n", "S", ":HopChar1<CR>", opts)
