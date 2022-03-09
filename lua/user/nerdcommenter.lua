-- Create default mappings
vim.g.NERDCreateDefaultMappings = 0

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1

-- vim.api.nvim_set_keymap("n", "gcc", ":call nerdcommenter#Comment(0, 'Comment')<CR>", { silent = true })
-- vim.api.nvim_set_keymap("n", "gcu", ":call nerdcommenter#Comment(0, 'Uncomment')<CR>", { silent = true })
-- vim.api.nvim_set_keymap("n", "gc<Space>", ":call nerdcommenter#Comment(0, 'Toggle')<CR>", { silent = true })

vim.api.nvim_set_keymap("n", "gcc", ":call nerdcommenter#Comment(0, 'Toggle')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gci", ":call nerdcommenter#Comment(0, 'Invert')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcm", ":call nerdcommenter#Comment(0, 'Minimal')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcn", ":call nerdcommenter#Comment(0, 'Nested')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcs", ":call nerdcommenter#Comment(0, 'Sexy')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcy", ":call nerdcommenter#Comment(0, 'Yank')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcb", ":call nerdcommenter#Comment(0, 'AlignBoth')<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gcl", ":call nerdcommenter#Comment(0, 'AlignLeft')<CR>", { silent = true })


-- vim.api.nvim_set_keymap("v", "gcc", ":call nerdcommenter#Comment(0, 'Comment')<CR>", { silent = true })
-- vim.api.nvim_set_keymap("v", "gcu", ":call nerdcommenter#Comment(0, 'Uncomment')<CR>", { silent = true })
-- vim.api.nvim_set_keymap("v", "gc<Space>", ":call nerdcommenter#Comment(0, 'Uncomment')<CR>", { silent = true })

vim.api.nvim_set_keymap("v", "gcc", ":call nerdcommenter#Comment(0, 'Toggle')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gci", ":call nerdcommenter#Comment(0, 'Invert')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcm", ":call nerdcommenter#Comment(0, 'Minimal')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcn", ":call nerdcommenter#Comment(0, 'Nested')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcs", ":call nerdcommenter#Comment(0, 'Sexy')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcy", ":call nerdcommenter#Comment(0, 'Yank')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcb", ":call nerdcommenter#Comment(0, 'AlignBoth')<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "gcl", ":call nerdcommenter#Comment(0, 'AlignLeft')<CR>", { silent = true })
