return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
        ██████╗ ██████╗  ██████╗ ██╗  ██╗
       ██╔════╝██╔═══██╗██╔═══██╗██║ ██╔╝
       ██║     ██║   ██║██║   ██║█████╔╝
       ██║     ██║   ██║██║   ██║██╔═██╗
       ╚██████╗╚██████╔╝╚██████╔╝██║  ██╗
        ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
       ┌────────────────────────────────┐
       |        Now, Say My Name.       |
       └────────────────────────────────┘
]]
		dashboard.section.header.val = vim.split(logo, "\n")
		dashboard.section.buttons.val = {
			dashboard.button(
				"p",
				" " .. " 查看项目",
				"<cmd>Telescope projects layout_config={height=0.6,width=0.6}<cr>"
			),
			dashboard.button(
				"f",
				"󰍉 " .. " 查找文件",
				"<cmd>Telescope find_files theme=dropdown previewer=false layout_config={height=0.3}<cr>"
			),
			dashboard.button("n", " " .. " 新建文件", [[<cmd> ene <BAR> startinsert <cr>]]),
			dashboard.button(
				"s",
				" " .. " 恢复会话",
				[[<cmd> lua require('persistence').load({ last = true }) <cr>]]
			),
			dashboard.button("m", " " .. " 查看会话", [[<cmd> lua require('persistence').select() <cr>]]),
			dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
			dashboard.button("q", "󰗼 " .. " 退出", "<cmd> qa <cr>"),
		}
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.opts.layout[1].val = 4
		return dashboard
	end,
	config = function(_, dashboard)
		require("alpha").setup(dashboard.opts)

		-- 透明背景：清除 Alpha 系列高亮组的背景色，让启动页透出终端背景
		-- (transparent.nvim 运行时 alpha 尚未加载，这里必须手动兜底)
		-- 挂载 ColorScheme 事件：不同主题可能重新设置 Alpha 组背景，切换后统一清掉
		-- 获取所有高亮组名：0.12 移除了 nvim_get_hl_groups，用 :highlight 输出兜底
		local function get_all_groups()
			if vim.api.nvim_get_hl_groups then
				return vim.api.nvim_get_hl_groups()
			end
			local out = vim.api.nvim_exec2("highlight", { output = true }).output
			local groups = {}
			for line in out:gmatch("[^\r\n]+") do
				local name = line:match("^(%S+)")
				if name then
					groups[#groups + 1] = name
				end
			end
			return groups
		end
		local function clear_alpha_bg()
			for _, name in pairs(get_all_groups()) do
				if type(name) == "string" and vim.startswith(name, "Alpha") then
					-- 读取完整属性后只改 bg，保留 fg 等（直接 set_hl({bg=...}) 会清掉前景色）
					local attrs = vim.api.nvim_get_hl(0, { name = name })
					if attrs.bg then
						attrs.bg = "NONE"
						vim.api.nvim_set_hl(0, name, attrs)
					end
				end
			end
		end
		clear_alpha_bg()
		vim.api.nvim_create_autocmd("ColorScheme", {
			desc = "主题切换后保持 Alpha 启动页透明",
			callback = clear_alpha_bg,
		})

		-- vim.api.nvim_create_autocmd("User", {
		--      once = true,
		--      pattern = "LazyVimStarted",
		--      callback = function()
		--              local stats = require("lazy").stats()
		--              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
		--              dashboard.section.footer.val = "⚡ Neovim 已加载 "
		--                      .. stats.loaded
		--                      .. "/"
		--                      .. stats.count
		--                      .. " 个插件 用时 "
		--                      .. ms
		--                      .. " 毫秒"
		--              pcall(vim.cmd.AlphaRedraw)
		--      end,
		-- })
	end,
}
