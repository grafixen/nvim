-- wrap selection in JSON.stringify(*)
vim.api.nvim_buf_set_keymap(0, "v", ",js", [[cJSON.stringify(<c-r>"<esc>>]], { noremap = false })

-- wrap selection in console.log
vim.api.nvim_buf_set_keymap(0, "v", ",cl", [[cconsole.log(<c-r>"<esc>]], { noremap = false })
