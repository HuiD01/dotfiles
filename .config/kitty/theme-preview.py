#!/usr/bin/env python3
"""Render a practical ANSI color preview for the active Kitty theme."""

from __future__ import annotations

RESET = "\033[0m"
BOLD = "\033[1m"
DIM = "\033[2m"
ITALIC = "\033[3m"
UNDERLINE = "\033[4m"
REVERSE = "\033[7m"


def color(text: str, code: int) -> str:
    return f"\033[{code}m{text}{RESET}"


def rule(title: str) -> None:
    width = 86
    label = f" {title} "
    print(f"\n{color('─' * 3 + label, 36)}{color('─' * (width - len(label) - 3), 90)}")


print()
print(color("  KITTY THEME LAB  ", 30) + color("  ANSI 16-color rendering  ", 36))
print(color("  Change themes with: kitty +kitten themes  ", 90))

rule("Python syntax")

print(f"{color('from', 35)} {color('dataclasses', 37)} {color('import', 35)} {color('dataclass', 36)}")
print()
print(color("# 保留最近 N 次观察", 90))
print(color("@dataclass", 35) + color("(slots=True)", 37))
print(f"{color('class', 35)} {color('Sample', 33)}:")
print(f"    {color('name', 36)}: {color('str', 36)} = {color(chr(34) + 'afterglow' + chr(34), 32)}")
print(f"    {color('score', 36)}: {color('float', 36)} = {color('97.5', 33)}")
print()
print(f"{color('def', 35)} {color('fibonacci', 34)}({color('n', 37)}: {color('int', 36)}) -> {color('list', 36)}[{color('int', 36)}]:")
print(f"    {color('values', 37)} = [{color('0', 33)}, {color('1', 33)}]")
print(f"    {color('while', 35)} {color('len', 34)}({color('values', 37)}) < {color('n', 37)}:")
print(f"        {color('values', 37)}.{color('append', 34)}({color('sum', 34)}({color('values', 37)}[{color('-2', 33)}:]))")
print(f"    {color('return', 35)} {color('values', 37)}")

rule("Diff and diagnostics")

print(color("@@ -18,3 +18,4 @@", 36))
print(color("- old_value = compute(input)", 31))
print(color("+ new_value = compute(input, retries=3)", 32))
print(color("! warning: retry count is unusually high", 33))
print(color("× error: unable to connect to cache", 31))
print(color("i info: using local configuration", 34))

rule("Selection, paths and prompt")

print("normal  " + REVERSE + " selected text " + RESET + "  " + UNDERLINE + color("linked text", 34))
print(color("~/Projects/ember/src", 34) + color("/", 90) + color("main.ts", 37))
print(color("main", 32) + "  " + color("↑1", 33) + "  " + color("●2", 31))
print(color("hui@studio", 36) + color(":", 90) + color("~/Projects/ember", 34) + color(" $ ", 32) + "kitty +kitten themes")

rule("ANSI palette")

names = ("black", "red", "green", "yellow", "blue", "magenta", "cyan", "white")
normal_codes = (40, 41, 42, 43, 44, 45, 46, 47)
bright_codes = (100, 101, 102, 103, 104, 105, 106, 107)
for name, normal, bright in zip(names, normal_codes, bright_codes):
    print(f"  {color(f' {name:^11} ', normal)} {color(f' bright {name:^10} ', bright)}")

print()
print(color("这些代码和诊断色使用 ANSI 0–15，由当前 Kitty 主题直接控制。", 37))
print(color("Neovim 开启 termguicolors 时，会优先使用自己的十六进制配色；Kitty 主题只决定终端底色和 ANSI 色。", 90))
print()
