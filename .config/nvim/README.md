## 环境要求

- **Neovim ≥ 0.12**(使用 `vim.lsp.config` / `vim.lsp.enable` 等 0.11+ API)
- 系统工具:git、ripgrep、fd、lazygit、gcc、make、unzip、python3
- 可选:**Neovide**(GUI,自动加载 `lua/neovide/` 配置)

## 安装

```bash
git clone https://github.com/HuiD01/dotfiles.git
# 方式一:拷贝
rsync -a --exclude=".git" dotfiles/.config/nvim/ ~/.config/nvim/

首次启动 lazy.nvim 会自动安装全部插件,并触发 mason 安装 LSP 服务器,请保持网络通畅。

> 更新配置:`fish` 下运行 `dotsync`(rsync 镜像 `~/.config/{yazi,fish,nvim}` → `~/dotfiles` 并自动 commit + push)。

## 目录结构

```
~/.config/nvim/
├── init.lua                  # 入口:加载 core / features / neovide
├── lua/
│   ├── core/                 # 基础配置
│   │   ├── basic.lua         #   编辑器基础选项(行号、缩进、搜索、剪贴板等)
│   │   ├── autocmd.lua       #   自定义事件(LazyFile)与自动命令
│   │   ├── keymap.lua        #   全局键位(leader = 空格)
│   │   └── lazy.lua          #   lazy.nvim 引导 + 插件模块导入
│   ├── features/             # 自写功能
│   │   ├── switch-theme.lua  #   :ThemeSwitch 主题切换器(Telescope 选择)
│   │   └── theme-list.lua    #   可选主题注册表(新增主题在此维护)
│   ├── plugins/              # 插件配置(按类别分目录,懒加载)
│   │   ├── editor/           #   treesitter、neo-tree、autopairs 等
│   │   ├── git/              #   gitsigns、lazygit
│   │   ├── lsp/              #   lspconfig、mason、blink.cmp、conform
│   │   │   └── config/       #   servers.lua(LSP 列表)、formatters.lua(格式化列表)
│   │   ├── navigation/       #   telescope、which-key、harpoon
│   │   ├── ui/               #   alpha、lualine、bufferline、noice、transparent
│   │   ├── utils/            #   flash、ufo、trouble、persistence 等
│   │   └── theme.lua         #   主题插件(懒加载,供切换器使用)
│   └── neovide/              # Neovide 专用配置(缩放、光标特效、标题栏)
```

## 插件一览

| 类别 | 插件 |
|---|---|
| 启动页 | alpha-nvim |
| 文件管理 | neo-tree |
| 模糊查找 | telescope(+fzf-native / file-browser / live-grep-args) |
| 补全 | blink.cmp(+friendly-snippets) |
| LSP | nvim-lspconfig、mason、fidget |
| 格式化 | conform(+formatters.lua 工具列表) |
| 语法 | nvim-treesitter、rainbow-delimiters |
| 缩进显示 | indent-blankline、mini-indentscope |
| 折叠 | ufo |
| 跳转 | flash(s/S/gl)、harpoon、aerial(大纲) |
| Git | gitsigns、lazygit |
| 会话 | persistence(会话恢复/保存) |
| UI | lualine、bufferline、noice、nvim-notify、web-devicons、transparent |
| 文档 | render-markdown(内联渲染) |
| 工具 | toggleterm、trouble、todo-comments、colorizer、nvim-surround |

## 快捷键

`<leader>` = **空格键**。按空格会弹出 which-key 分组提示,也可用 `<leader>fk` 查询全部键位。

### 高频

| 按键 | 功能 |
|---|---|
| `<leader>e` | 打开 Neotree 文件树 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局内容搜索(live_grep) |
| `<leader>gg` | 打开 Lazygit |
| `<leader>T` | 切换主题(ThemeSwitch) |
| `<leader>H` | 帮助文档查询 |
| `<leader>qq` | 保存并退出 |

### 分组

| 分组 | 功能 |
|---|---|
| `<leader>f` | 文件查找(ff 文件 / fs 字符 / fg 全局 / fr 高级 / fb 缓冲区 / fo 历史 / fk 键位) |
| `<leader>b` | 缓冲区操作(bb 切换 / bd 删除 / bo 关闭其他 / bp 固定) |
| `<leader>c` | LSP 操作(ca 代码操作 / cr 引用 / cR 重命名 / ce 诊断 / cf 大纲 / ci 实现 / c\[ 被调 / c\] 调用) |
| `<leader>m` | Harpoon 标记(ma 添加 / md 移除 / mm 菜单 / m1-3 跳转) |
| `<leader>w` | 窗口操作 |
| `<leader>g` | Git 操作 |
| `<leader>h` | Git Hunk / 信息 |
| `<leader>t` | 终端(ToggleTerm) |
| `<leader>x` | 问题查看(Trouble) |
| `<leader>q` | 退出 |

### 其他常用

| 按键 | 功能 |
|---|---|
| `s` / `S` | Flash 字符跳转 / Treesitter 跳转 |
| `gl` | Flash 行跳转 |
| `gd` / `gD` / `gi` / `gr` / `gt` | LSP 定义 / 声明 / 实现 / 引用 / 类型定义 |
| `K` | LSP Hover |
| `<C-s>` | 保存 |
| `<A-j>` / `<A-k>` | 行移动 |

## LSP 与格式化

**服务器列表**(`lua/plugins/lsp/config/servers.lua` 维护,mason 自动安装):

| 语言 | 服务器 |
|---|---|
| C / C++ | clangd |
| Rust | rust-analyzer(clippy 检查) |
| Lua | lua_ls |
| Python | basedpyright、ruff |
| TypeScript / JavaScript | ts_ls |
| HTML / CSS / Tailwind | vscode-html / cssls / tailwindcss |
| JSON / Emmet | emmet_ls |
| Markdown | marksman |
| YAML | yamlls |

**格式化**(`formatters.lua` 维护,由 conform 驱动,LSP 自带格式化已禁用避免冲突):clang-format(C/C++)、stylua(Lua)、eslint_d + prettierd(JS/TS)、prettierd(CSS/HTML/YAML/Markdown/JSON)、taplo(TOML)、rustfmt(Rust)、ruff(Python,含 lint 修复与 import 整理)。

> 新增语言:在 `servers.lua` / `formatters.lua` 加一行即可,重启自动安装。

## 主题系统

- 切换:`:ThemeSwitch`(Telescope 选择器,支持 `theme=ivy` 等参数)
- 选择结果持久化到 `~/.local/share/nvim/theme`(格式 `主题名:light|dark`),下次启动自动加载
- 可选主题注册在 `lua/features/theme-list.lua`(新增主题插件后在 `theme.lua` 加规格 + 在此注册)
- 主题加载失败会自动回退默认主题,不会崩启动

## Neovide

用 Neovide 启动时自动加载 `lua/neovide/` 配置:缩放(`<C-=>` / `<C-->`)、光标特效、框线绘制、标题栏颜色等。透明背景在 Neovide 下自动禁用(与终端透明分开处理)。

## 排错

```vim
:checkhealth        " 内建与插件健康检查
:Lazy health        " 插件安装状态
:lua vim.lsp.log      " LSP 日志(日志路径 ~/.local/state/nvim/lsp.log)
```

常见问题:

- **插件缺失/加载失败**:先跑 `:Lazy` 确认安装状态,再 `:Lazy update`
- **LSP 连不上**:确认 `servers.lua` 里的服务器已由 mason 安装(`:Mason` 查看),检查 LSP 日志
- **搜索慢/卡**:避免从家目录启动 nvim 后打开文件触发 workspace 级扫描;basedpyright 的 `diagnosticMode` 可改为 `"openFilesOnly"`
- **树形 parser 缺失**:`:TSInstall <语言>`(需要 tree-sitter CLI,当前未安装,可用 `cargo install tree-sitter-cli` 补)
