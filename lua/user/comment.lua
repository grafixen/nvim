local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local status_ok_1, _ = pcall(require, "lsp-inlayhints")
if not status_ok_1 then
	return
end

comment.setup({
  extra = {
    above = 'gcO',  ---Add comment on the line above
    below = 'gco',  ---Add comment on the line below
    eol = 'gcA',    ---Add comment at the end of line
  },
	pre_hook = function(ctx)
		-- For inlay hints
		local line_start = (ctx.srow or ctx.range.srow) - 1
		local line_end = ctx.erow or ctx.range.erow
		require("lsp-inlayhints.core").clear(0, line_start, line_end)

		-- c.f. Default Comment Setup
		local U = require("Comment.utils")

		-- Determine whether to use linewise or blockwise commentstring
		local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

		-- Determine the location where to calculate commentstring from
		local location = nil
		if ctx.ctype == U.ctype.blockwise then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = type,
			location = location,
		})
	end,
})
