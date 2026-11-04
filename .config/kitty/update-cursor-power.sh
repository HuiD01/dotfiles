#!/bin/zsh
set -euo pipefail

config_dir="$HOME/.config/kitty"
config_file="$config_dir/cursor-power.conf"
state_file="$config_dir/.cursor-power-state"
power_info="$(/usr/bin/pmset -g batt 2>/dev/null || true)"

if [[ "$power_info" == *"AC Power"* ]]; then
    mode=ac
    desired=$'# Managed by update-cursor-power.sh. Do not edit manually.\n# Current power source: AC\ncursor_trail 1\ncustom_shaders cursor-trail-motion-blur\n'
elif [[ "$power_info" == *"Battery Power"* ]]; then
    mode=battery
    desired=$'# Managed by update-cursor-power.sh. Do not edit manually.\n# Current power source: Battery\ncursor_trail 0\n'
else
    # Leave the last known configuration untouched if pmset is unavailable.
    exit 0
fi

previous=""
if [[ -r "$state_file" ]]; then
    previous="$(<"$state_file")"
fi
if [[ "$previous" == "$mode" && -f "$config_file" ]]; then
    exit 0
fi

config_tmp="${config_file}.tmp.$$"
state_tmp="${state_file}.tmp.$$"
trap 'rm -f "$config_tmp" "$state_tmp"' EXIT

printf '%s' "$desired" > "$config_tmp"
printf '%s\n' "$mode" > "$state_tmp"
mv -f "$config_tmp" "$config_file"
mv -f "$state_tmp" "$state_file"
trap - EXIT
