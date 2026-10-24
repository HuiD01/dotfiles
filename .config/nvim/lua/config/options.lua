-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Python LSP: 使用 basedpyright（支持 inlay hints）代替 pyright
vim.g.lazyvim_python_lsp = "basedpyright"

-- 默认关闭 inlay hints，可用 <leader>uh 切换
-- vim.g.lazyvim_inlay_hints = false

-- 全局禁用拼写检查（默认关闭，可用快捷键切换）
vim.opt.spell = false

-- 1. 禁用注释自动延续（按回车后下一行不自动继承注释）
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

-- 2. 允许左右方向键换行
vim.opt.whichwrap:append("<,>,h,l")

-- 3. 默认开启自动换行（行太长时自动折到下一行显示）
vim.opt.wrap = true

-- 光标离上下边框最少1行，改成0就是完全贴边
vim.opt.scrolloff = 2

-- ===== 以下为本机保留的个人偏好（切换配置时特意保留）=====

-- 行号：不显示相对行号
vim.opt.relativenumber = false

-- 与系统剪贴板互通
vim.opt.clipboard = "unnamedplus"

-- SSH 远程场景：系统剪贴板拿不到，改用 OSC 52 走终端写回本地
local function is_ssh()
  return vim.env.SSH_CONNECTION
      or vim.env.SSH_CLIENT
      or vim.env.SSH_TTY
end

if is_ssh() then
  local function paste()
    -- 从默认寄存器 "" 中获取内容，并按换行符分割
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""), -- 同时返回寄存器类型
    }
  end
  -- NOTE: 在远程 ssh 连接的终端中使用 osc52
  -- 这里要说明的是 flash 在使用该 osc52 接管复制时，
  -- 无法使用 flash 的远程复制，无法使用 p 粘贴，请使用系统自带的粘贴快捷键。
  -- 更推荐在远程连接时使用系统自带的粘贴快捷键。
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end
