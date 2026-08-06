# 默认编辑器：yazi 打开文件、git commit、fzf 的 fe 函数等都会用到
set -gx EDITOR nvim
set -gx VISUAL nvim

# dotfiles 管理：镜像目录方案
# 改完配置后执行 dotsync：拷贝配置到 ~/dotfiles 并推送 GitHub
function dotsync
    # 1. 同步配置到镜像仓库（排除自动生成/备份文件）
    rsync -a --delete --exclude=".DS_Store" --exclude="yazi.toml.bak" \
        ~/.config/yazi/ ~/dotfiles/.config/yazi/
    # fish 只同步核心文件（completions/conf.d/functions 是工具自动生成的，不纳入）
    rsync -a --exclude=".DS_Store" \
        ~/.config/fish/config.fish ~/.config/fish/fish_plugins ~/dotfiles/.config/fish/
    # nvim 同步（排除 .git：本地目录自带仓库历史，不入库）
    rsync -a --delete --exclude=".git" --exclude=".DS_Store" \
        ~/.config/nvim/ ~/dotfiles/.config/nvim/

    # 2. 提交并推送
    cd ~/dotfiles
    git add -A
    if not git diff --cached --quiet
        git commit -m "sync dotfiles"
        git push
    else
        echo "无改动，无需同步"
    end
end

if status is-interactive
    # fzf
    fzf --fish | source
    # zoxide
    zoxide init fish | source
end

# fzf: use fd for faster file search
set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"

# fzf: interactive file open
function fe
    set file (fd --type f | fzf --preview 'bat --style=numbers --color=always {}')
    and $EDITOR $file
end

# fzf: interactive cd
function fcd
    set dir (fd --type d | fzf)
    and cd $dir
end

# pnpm
set -gx PNPM_HOME "/Users/hui/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
