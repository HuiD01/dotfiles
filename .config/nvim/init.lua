require('vim._core.ui2').enable({
  enable = true, -- Whether to enable or disable the UI.
})
require("core.autocmd")
require("core.basic")
require("core.keymap")
require("core.command")
require("core.ime")       -- 中文输入法兜底：普通模式下全角标点当英文用
require("plugins")
