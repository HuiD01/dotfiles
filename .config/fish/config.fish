# 默认编辑器：yazi 打开文件、git commit、fzf 的 fe 函数等都会用到
set -gx EDITOR nvim
set -gx VISUAL nvim

# dotfiles 管理：git 数据在 ~/.dotfiles.git，工作树 = $HOME
# 用法：config status / config add .config/yazi / config commit / config push
function config
    git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME" $argv
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
