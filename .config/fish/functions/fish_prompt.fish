function fish_prompt --description 'Restrained single-line prompt with Git branch'
    set -l normal (set_color normal)
    set -l identity_color (set_color '#ffffff')
    set -l separator_color (set_color '#6e7681')
    set -l path_color (set_color '#58a6ff')
    set -l branch_color (set_color '#7ee787')
    set -l dirty_color (set_color '#d29922')
    set -l prompt_color (set_color '#ffa657')

    set -l user_name (id -un)
    set -l host_name (hostname -s)
    set -l current_path (prompt_pwd --full-length-dirs 2)

    echo -n -s $identity_color $user_name '@' $host_name
    echo -n -s $separator_color ':' $normal
    echo -n -s $path_color $current_path

    set -l branch (command git branch --show-current 2>/dev/null)
    if test -z "$branch"
        set branch (command git rev-parse --short HEAD 2>/dev/null)
    end

    if test -n "$branch"
        set -l dirty_mark
        set -l git_color $branch_color
        set -l git_status (command git status --porcelain 2>/dev/null | string collect)
        if test -n "$git_status"
            set dirty_mark '*'
            set git_color $dirty_color
        end
        echo -n -s $normal ' '
        echo -n -s $git_color $branch $dirty_mark
    end

    echo -n -s $prompt_color '$ ' $normal
end
