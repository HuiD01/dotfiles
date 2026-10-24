-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 切换 buffer / 失焦时自动保存
vim.opt.autowriteall = true

-- HTML 浏览器实时预览（:HtmlPreview）
require("config.html_preview")

-- 中文输入法兜底：普通模式下把全角标点当英文用
require("config.ime")
