local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Surround
vim.cmd([[nmap <leader>` ysiw`]])
vim.cmd([[nmap <leader>' ysiw']])
vim.cmd([[nmap <leader>" ysiw"]])
vim.cmd([[nmap <leader>) ysiw)]])
vim.cmd([[nmap <leader>} ysiw}]])
vim.cmd([[nmap <leader>] ysiw]\]])

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-]>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<C-[>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<C-b>", ":BufferLinePick<CR>", opts)

-- Insert --
-- Daily Workflow
keymap("i", "jl", "<Esc>la", opts)
keymap("i", "jh", "<Esc>i", opts)
keymap("i", "jj", "<Esc>A", opts)
keymap("i", "jk", "<Esc>^i", opts)
keymap("i", "j;", "<Esc>o", opts)
keymap("i", "j:", "<Esc>O", opts)

-- Visual --
-- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Terminal --
-- Better terminal navigation
-- local term_opts = { silent = true }
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
