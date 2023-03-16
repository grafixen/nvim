local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local function is_ft(b, ft)
	return vim.bo[b].filetype == ft
end

bufferline.setup({
	options = {
		mode = "buffers",
		numbers = function(opts)
			return string.format("%s.", opts.ordinal)
		end,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "(" .. count .. ")"
		end,
		separator_style = "slant",
		show_tab_indicators = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
		custom_filter = function(buf, buf_nums)
			local logs = vim.tbl_filter(function(b)
				return is_ft(b, "log")
			end, buf_nums)
			if vim.tbl_isempty(logs) then
				return true
			end
			local tab_num = vim.fn.tabpagenr()
			local last_tab = vim.fn.tabpagenr("$")
			local is_log = is_ft(buf, "log")
			if last_tab == 1 then
				return true
			end
			-- only show log buffers in secondary tabs
			return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
		end,
		offsets = {
			{
				filetype = "undotree",
				text = "Undotree",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "flutterToolsOutline",
				text = "Flutter Outline",
				highlight = "PanelHeading",
			},
			{
				filetype = "packer",
				text = "Packer",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
		hover = {
			enabled = true, -- requires nvim 0.8+
			delay = 200,
			reveal = { "close" },
		},
		sort_by = "id",
		-- sort_by = function(buffer_a, buffer_b)
		-- 	local mod_a = ((vim.loop.fs_stat(buffer_a.path) or {}).mtime or {}).sec or 0
		-- 	local mod_b = ((vim.loop.fs_stat(buffer_b.path) or {}).mtime or {}).sec or 0
		-- 	return mod_a > mod_b
		-- end,
	},
})

local keymap = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

-- Magic buffer-picking mode
keymap("n", "<Leader>;", ":BufferLinePick<CR>", options)
