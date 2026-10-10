# tmux 键位速查

> 从运行中的 server 用 `tmux list-keys` 导出核对整理，反映真实生效的绑定。
> 配置：`~/.config/tmux/tmux.conf`　环境：Ghostty 1.3.1 + AeroSpace　整理：2026-10-10

---

## 0. 先读这三行

| 做法 | 说明 |
|---|---|
| `Ctrl-a` → 松开 → 功能键 | tmux 是**两步按键**，不是三个键一起按 |
| `Ctrl-a Ctrl-a` | 把 `Ctrl-a` 本身透传给内层程序（vim/fish 的行首键） |
| `Ctrl-a ?` | 忘了就按它，弹出中文速查菜单（鼠标可点） |

### 三层分区：一个修饰键 = 一层

| 按键 | 作用 | 归属 |
|---|---|---|
| `Alt+1` ~ `Alt+9` | 切工作区 | AeroSpace |
| `Alt+h/j/k/l` | 跨应用窗口间移动 | AeroSpace |
| `Cmd+1` ~ `Cmd+9` | 切 tmux 窗口（**零前缀**） | tmux（借道 Ghostty） |
| `Ctrl-a 1` ~ `9` | 切 tmux 窗口 | tmux |
| `Cmd+D` | 切分 tmux 面板（**零前缀**） | tmux（借道 Ghostty） |
| `Ctrl-a \|` | 切分 tmux 面板 | tmux |
| `Cmd+C` / `Cmd+V` | 系统剪贴板 | Ghostty |

---

## 1. 会话 session

| 按键 / 命令 | 功能 |
|---|---|
| `tmux new -As main` | 新建或接入（**最常用的一行**，有就进、没有就建） |
| `Ctrl-a d` | 挂起（离开，现场保留） |
| `tmux a` | 回来 |
| `Ctrl-a s` | 交互式切换会话 |
| `Ctrl-a (` | 上一个会话 |
| `Ctrl-a )` | 下一个会话 |
| `Ctrl-a $` | 重命名当前会话 |
| `Ctrl-a D` | 选择要踢掉的客户端 |
| `tmux ls` | 列出所有会话 |
| `tmux kill-session -t 名字` | 杀掉会话 |

---

## 2. 窗口 window（相当于标签页）

| 按键 | 功能 |
|---|---|
| `Ctrl-a c` | 新建窗口（**沿用当前目录**） |
| `Ctrl-a 1` ~ `9` | 按编号跳转（编号从 1 开始） |
| `Ctrl-a n` | 下一个窗口 |
| `Ctrl-a p` | 上一个窗口 |
| `Ctrl-a q` | 回到上一个窗口 ⚠️ 占用了原来的 `Ctrl-a l` |
| `Ctrl-a ,` | 重命名窗口 |
| `Ctrl-a &` | 关闭窗口（会问 y/n） |
| `Ctrl-a w` | 交互式选窗口 |
| `Ctrl-a <` | 窗口菜单（改名/杀/交换/新建），鼠标可点 |
| `Ctrl-a f` | 跨窗口按标题搜索 |

### 2.1 零前缀：Ghostty 桥接

不发按键、直接发字节，**ssh 到远程同样有效**。

| 按键 | 等价于 | 功能 |
|---|---|---|
| `Cmd+1` ~ `Cmd+9` | `Ctrl-a 1` ~ `9` | 切 tmux 窗口 |
| `Ctrl+Tab` | `Ctrl-a n` | 下一个窗口 |
| `Ctrl+Shift+Tab` | `Ctrl-a p` | 上一个窗口 |
| `Cmd+Shift+]` | `Ctrl-a n` | 下一个窗口 |
| `Cmd+Shift+[` | `Ctrl-a p` | 上一个窗口 |
| `Cmd+T` | `Ctrl-a c` | 新建窗口（取代会挤坏 AeroSpace 布局的原生标签） |
| `Cmd+W` | — | 关掉 Ghostty 窗口（tmux 只是 detach，**会话不死**） |
| `Cmd+Shift+W` | — | 关闭整个窗口 |

---

## 3. 面板 pane（相当于分屏）

| 按键 | 功能 |
|---|---|
| `Ctrl-a \|` | 竖着切（左右），沿用当前目录 |
| `Ctrl-a -` | 横着切（上下），沿用当前目录 |
| `Ctrl-a h` | 切到左面板 |
| `Ctrl-a j` | 切到下方面板 |
| `Ctrl-a k` | 切到上方面板 |
| `Ctrl-a l` | 切到右面板 |
| `Ctrl-a ←↑↓→` | 同上，方向键版本 |
| `Ctrl-a o` | 下一个面板（循环） |
| `Ctrl-a ;` | 回到上一个活动面板 |
| `Ctrl-a H` | 向左扩 5 格（可按住连按） |
| `Ctrl-a J` | 向下扩 5 格（可按住连按） |
| `Ctrl-a K` | 向上扩 5 格（可按住连按） |
| `Ctrl-a L` | 向右扩 5 格（可按住连按） |
| `Ctrl-a z` | 最大化 / 还原当前面板 |
| `Ctrl-a x` | 关闭面板 |
| `Ctrl-a !` | 把面板拆成独立窗口 |
| `Ctrl-a {` | 与上一个面板交换位置 |
| `Ctrl-a }` | 与下一个面板交换位置 |
| `Ctrl-a Space` | 切换预设布局 |
| `Ctrl-a E` | 均分所有面板 |
| `Ctrl-a >` | 面板菜单（分屏/杀/缩放/交换/复制行），鼠标可点 |
| `Ctrl-a %` | 竖着切（出厂默认键，保留） |
| `Ctrl-a "` | 横着切（出厂默认键，保留） |

### 3.1 零前缀：Ghostty 桥接

| 按键 | 等价于 | 功能 |
|---|---|---|
| `Cmd+D` | `Ctrl-a \|` | 竖着切面板 |
| `Cmd+Shift+D` | `Ctrl-a -` | 横着切面板 |
| `Cmd+Alt+←` | `Ctrl-a h` | 切到左面板 |
| `Cmd+Alt+↓` | `Ctrl-a j` | 切到下方面板 |
| `Cmd+Alt+↑` | `Ctrl-a k` | 切到上方面板 |
| `Cmd+Alt+→` | `Ctrl-a l` | 切到右面板 |
| `Cmd+Ctrl+←↓↑→` | `Ctrl-a H J K L` | 调整面板大小 |
| `Cmd+Shift+Enter` | `Ctrl-a z` | 最大化 / 还原 |
| `Cmd+[` | `Ctrl-a ;` | 上一个活动面板 |
| `Cmd+]` | `Ctrl-a o` | 下一个面板 |

> `Alt+←` / `Alt+→`（不带 Cmd）仍是 Ghostty 的按词跳（`esc:b` / `esc:f`），未改动。
> 桥接键需配置生效后才可用：`Cmd+Shift+,` 重载，改键位建议**完全重启 Ghostty**。

---

## 4. 复制模式

进入 `Ctrl-a [`　退出 `q` 或 `Esc`

| 按键 | 功能 |
|---|---|
| `v` | 开始选择（vi 风格） |
| `y` | **复制并退出，直接进 macOS 系统剪贴板** |
| 鼠标拖拽 | 松手即复制到系统剪贴板 |
| `h j k l` | 移动光标 |
| `g` / `G` | 跳到历史顶部 / 底部 |
| `/` | 向下搜索 |
| `?` | 向上搜索 |
| `n` | 重复搜索 |
| `Ctrl+u` / `Ctrl+d` | 半页上下 |
| `Ctrl+b` / `Ctrl+f` | 整页上下 |
| `V` | 整行选择 |
| `Ctrl+v` | 矩形选择 |
| `Space` | 同 `v`，开始选择 |

粘贴：`Ctrl-a ]`（tmux 缓冲区）或 `Cmd+V`（系统剪贴板）

---

## 5. 鼠标

| 操作 | 功能 |
|---|---|
| 左键点面板 | 切换焦点 |
| 拖动面板边框 | 调整大小 |
| 滚轮 | 翻历史 / 滚动 |
| 右键点面板 | 打开面板菜单（分屏/杀/缩放/交换/复制行） |
| 右键点状态栏 | 打开窗口菜单（改名/杀/交换/新建） |
| 中键 | 粘贴缓冲区 |

---

## 6. 速查与命令模式

| 按键 | 功能 |
|---|---|
| `Ctrl-a ?` | 中文速查菜单（居中弹出，鼠标可点） |
| `Ctrl-a m` | 同一个速查菜单（字母备用入口） |
| `Ctrl-a /` | fzf 全量键位搜索（永远和实际绑定一致） |
| `Ctrl-a :` | 命令模式 |
| `Ctrl-a r` | 重载 tmux 配置 |

键位忘了不要紧，**知道命令名就能干活**：

| 命令 | 功能 |
|---|---|
| `split-window -h` | 竖着切 |
| `split-window -v` | 横着切 |
| `select-pane -L` | 往左切面板 |
| `resize-pane -L 5` | 往左扩 5 格 |
| `new-window` | 新窗口 |
| `kill-pane` | 关面板 |
| `list-keys` | 看全部键位 |
| `list-windows` | 看全部窗口 |

---

## 7. ⚠️ 被本配置覆盖掉的出厂默认键

改键位的代价清单。**遇到"某个老教程里的键不灵了"，先看这里。**

| 按键 | 出厂默认 | 现在 | 替代方案 |
|---|---|---|---|
| `Ctrl-a l` | 回到上个窗口 | 切到右面板 | `Ctrl-a q` |
| `Ctrl-a L` | 切回上个会话 | 向右扩面板 | `Ctrl-a (` / `)` |
| `Ctrl-a q` | 显示面板编号 | 回到上个窗口 | `Ctrl-a w` |
| `Ctrl-a m` | 标记面板 | 速查菜单 | — |
| `Ctrl-a r` | 强制重绘 | 重载配置 | — |
| `Ctrl-a ?` | 列出键位 | 速查菜单 | `Ctrl-a /` |
| `Ctrl-a /` | 键位搜索提示 | fzf 搜索 | — |
| `Ctrl-a -` | 删除最近缓冲 | 横着切面板 | — |
| `Ctrl-a c` | 新建窗口 | 新建窗口（沿用当前目录） | — |
| `Ctrl-a C-b` | 透传前缀 | 已解绑，还给 fish | `Ctrl-a Ctrl-a` |

---

## 8. 配置与维护

| 项目 | 内容 |
|---|---|
| 配置文件 | `~/.config/tmux/tmux.conf` |
| 重载 | `Ctrl-a r` 或 `tmux source-file ~/.config/tmux/tmux.conf` |
| 校验语法 | `tmux -f ~/.config/tmux/tmux.conf new-session -d`（有错会立刻打印） |
| 看某键绑到哪 | `tmux list-keys -T prefix \| sed 's/  */ /g' \| grep 键名` |

### ⚠️ 改速查菜单时的头号陷阱

`display-menu` 的每一项是 **「名字 / 键 / 命令」三个参数**。命令里只要含空格，就**必须整体用引号包成一个参数**，否则三元组错位，整条命令报 `not enough arguments` 然后**静默失败、屏幕毫无反应**：

```tmux
# ✅ 正确：命令是一个参数
"新窗口"  c  "new-window -c '#{pane_current_path}'"

# ❌ 错误：命令被拆成 4 个参数，整个菜单全废
"新窗口"  c  new-window -c "#{pane_current_path}"
```

同理，空名字 `""` 单独一行 = 一条分隔线（只占 1 个参数，不要补键和命令）。

### 关键选项

| 选项 | 值 | 作用 |
|---|---|---|
| `prefix` | `C-a` | 前缀键 |
| `base-index` | `1` | 窗口编号从 1 开始，与 `Alt+1..9` 对称 |
| `pane-base-index` | `1` | 面板编号从 1 开始 |
| `renumber-windows` | `on` | 关窗口后自动补号 |
| `mouse` | `on` | 鼠标全功能 |
| `mode-keys` | `vi` | 复制模式用 vi 键位 |
| `set-clipboard` | `on` | tmux 的复制进系统剪贴板 |
| `history-limit` | `50000` | 回滚行数 |
| `escape-time` | `10` | vim 用户必改，Esc 无延迟 |
| `focus-events` | `on` | 切回面板时通知 vim 重绘 |

---

## 9. 排错

| 现象 | 原因 / 处理 |
|---|---|
| 按键完全没反应 | 先确认**在不在 tmux 里**：屏幕底部有状态栏才是 |
| 某个键没反应 | `tmux list-keys -T prefix` 看它到底绑到哪了 |
| 菜单弹不出来 | 手动跑 `tmux display-menu -T T "A" a "display-message hi"`，再对照第 8 节的引号陷阱 |
| 屏幕有东西卡着、按键被吃掉 | 可能有菜单/弹窗没关，按 `Esc` |
| 嵌套 tmux 里前缀失效 | 本地 tmux 吃掉了 `Ctrl-a`：按 `Ctrl-a Ctrl-a` 透传，或先 `Ctrl-a d` |
| `Cmd+1` / `Cmd+D` 没反应 | Ghostty 侧配置未生效：`Cmd+Shift+,` 重载，或完全重启 Ghostty |
| 老服务器上菜单报错 | tmux < 3.2 不支持 `display-menu` / `display-popup`，删掉配置里 `bind ?` / `bind m` / `bind /` 三行，其余照用 |

### 远程部署

```bash
scp ~/.config/tmux/tmux.conf 服务器:~/.tmux.conf
# 远端执行： tmux source-file ~/.tmux.conf
```

Ghostty 的 `Cmd+*` 桥接发的是**字节**，远程 tmux 一样有效。

---

## 10. 回滚

```bash
rm ~/.config/tmux/tmux.conf                                 # tmux 回到出厂 Ctrl-b
mv ~/.config/ghostty/config.bak ~/.config/ghostty/config    # Ghostty 还原
```
