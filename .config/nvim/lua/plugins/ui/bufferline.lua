return {
	"akinsho/bufferline.nvim",
	event = "User LazyFile",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			always_show_bufferline = true,
			buffer_close_icons = "⨉ ",
			close_icon = "⨉ ",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			enforce_regular_tabs = true,
			indicator = {
				style = "none",
			},
			separator_style = { "", "" },
			left_trunc_marker = "",
			right_trunc_marker = "",
			modified_icon = "●",
			max_average_window_width = 100,
			numbers = "none",
			show_buffer_icons = false, -- 不显示文件名前的文件类型图标
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			sort_by = "insert_after_current",
			offsets = {
				{
					filetype = "NvimTree",
					text = "项目目录",
					text_align = "left",
					separator = true,
					padding = 1,
				},
				{
					filetype = "neo-tree",
					text = "目录",
					text_align = "left",
					separator = true,
					padding = 1,
				},
			},
		},
	},
	keys = {
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "切换到下一个缓冲区" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "切换到上一个缓冲区" },
		{ "<leader>bb", "<cmd>e #<cr>", desc = "快速切换缓冲区" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "删除缓冲区" },
		{ "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "查询并跳转缓冲区" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "删除其他缓冲区" },
		{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "切换缓冲区固定状态" },
		{
			"<leader>bP",
			"<cmd>BufferLineGroupClose ungrouped<cr>",
			desc = "删除未固定的缓冲区",
		},
	},
}
