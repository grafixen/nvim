local M = {}

vim.cmd([[
  function Test()
    %SnipRun
    call feedkeys("\<esc>`.")
  endfunction
  function TestI()
    let b:caret = winsaveview()
    %SnipRun
    call winrestview(b:caret)
  endfunction
]])

function M.sniprun_enable()
	vim.cmd([[
    %SnipRun
    augroup _sniprun
     autocmd!
     autocmd TextChanged * call Test()
     autocmd TextChangedI * call TestI()
    augroup end
  ]])
	vim.notify("Enabled SnipRun")
end

function M.disable_sniprun()
	M.remove_augroup("_sniprun")
	vim.cmd([[
    SnipClose
    SnipTerminate
    ]])
	vim.notify("Disabled SnipRun")
end

function M.toggle_sniprun()
	if vim.fn.exists("#_sniprun#TextChanged") == 0 then
		M.sniprun_enable()
	else
		M.disable_sniprun()
	end
end

-- get length of current word
function M.get_word_length()
	local word = vim.fn.expand("<cword>")
	return #word
end

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
	local value = vim.api.nvim_get_option_value("showtabline", {})

	if value == 2 then
		value = 0
	else
		value = 2
	end

	vim.opt.showtabline = value

	vim.notify("showtabline" .. " set to " .. tostring(value))
end

local diagnostics_active = true
function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	if modified then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/n) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

function M.enable_format_on_save()
	vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
    augroup end
  ]])
	vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
	M.remove_augroup("format_on_save")
	vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

function M.get_schema()
	local schema = require("yaml-companion").get_buf_schema(0)
	if schema.result[1].name == "none" then
		return ""
	end
	return schema.result[1].name
end

vim.cmd([[ command! SnipRunToggle execute 'lua require("user.functions").toggle_sniprun()' ]])
vim.cmd([[ command! YamlGetSchema execute 'lua require("user.functions").get_schema()' ]])
vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]])

return M
