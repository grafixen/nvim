-- ORG BULLETS
-- https://github.com/akinsho/org-bullets.nvim
local cmp_status_ok, org_bullets = pcall(require, "org-bullets")
if not cmp_status_ok then
	return
end

org_bullets.setup()

-- BULLETS
-- https://github.com/dkarter/bullets.vim

-- Filetypes
vim.g.bullets_enabled_file_types = {
	"org",
	"markdown",
	"text",
	"gitcommit",
	"scratch",
}
