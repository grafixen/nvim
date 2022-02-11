local status_ok, tabnine = pcall(require, "tabnine")
if not status_ok then
	return
end

local tabnineCfg = tabnine.config
tabnineCfg:setup({
  max_lines = 1000;
	max_num_results = 20;
	sort = true;
	-- run_on_every_keystroke = true;
})
