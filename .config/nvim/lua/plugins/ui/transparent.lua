-- 因为透明插件无法再neovide中使用所以单独设置插件命令
if vim.g.neovide then
	-- 为 Neovide 的透明设置 Cmd 命令，并禁用透明插件的Cmd命令
	local state_file = vim.fn.stdpath("data") .. "/neovide_transparency" -- 透明度参数存储位置
	local f = io.open(state_file, "r")
	if f then
		vim.g.neovide_opacity = tonumber(f:read("*l")) or 1
		f:close()
	end
	vim.api.nvim_create_user_command("TransparentToggle", function()
		local next = (vim.g.neovide_opacity == 1.0) and 0.88 or 1.0
		vim.g.neovide_opacity = next

		local w = io.open(state_file, "w")
		if w then
			w:write(tostring(next))
			w:close()
		end
	end, {})
	return {}
else
	return {
		"xiyaowong/transparent.nvim",
		config = function()
			vim.g.transparent_enabled = true
				local function selected_buffer_groups()
					local groups = {
						BufferLineBufferSelected = true,
						BufferLineCloseButtonSelected = true,
						BufferLineModifiedSelected = true,
						BufferLineNumbersSelected = true,
						BufferLineDiagnosticSelected = true,
					}
					for _, group in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
						if group:find("Selected", 1, true) then
							groups[group] = true
						end
					end
					return vim.tbl_keys(groups)
				end
				local function emphasize_current_buffer()
					local highlight = {
						fg = 0x141415,
						bg = 0xe8e4dc,
						bold = true,
					}
					for _, group in ipairs(selected_buffer_groups()) do
						local attrs = vim.tbl_extend("force", highlight, {
							underline = false,
						})
						vim.api.nvim_set_hl(0, group, attrs)
					end
				end
			require("transparent").setup({
				extra_groups = {
					"NormalFloat",
					"NvimTreeNormal",
					"TelescopeNormal",
				},
					exclude_groups = selected_buffer_groups,
			})
			require("transparent").clear()
				require("transparent").clear_prefix("BufferLine")
				emphasize_current_buffer()
				local group = vim.api.nvim_create_augroup("cookvim_bufferline_emphasis", { clear = true })
				vim.api.nvim_create_autocmd("User", {
					group = group,
					pattern = "TransparentClear",
					callback = emphasize_current_buffer,
				})
				vim.api.nvim_create_autocmd("User", {
					group = group,
					pattern = "LazyFile",
					callback = function()
						vim.schedule(emphasize_current_buffer)
					end,
				})
			require("transparent").clear_prefix("TabLine")
			-- require("transparent").clear_prefix("WildMenu") -- possibly not necessary

			-- Lualine
			-- require("transparent").clear_prefix("lualine")

			-- Neo-tree
			require("transparent").clear_prefix("NeoTree")
		end,
	}
end
