-- ORG BULLETS
local cmp_status_ok, org_bullets = pcall(require, "org-bullets")
if not cmp_status_ok then
	return
end

org_bullets.setup()

-- BULLETS

-- Filetypes
vim.g.bullets_enabled_file_types = {
	"org",
	"markdown",
	"text",
	"gitcommit",
	"scratch",
}
