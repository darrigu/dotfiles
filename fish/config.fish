set fish_greeting

set -gx --prepend PATH "$HOME/.asdf/shims"

fish_config theme choose catppuccin-mocha
command -q vivid && set -gx LS_COLORS (vivid generate catppuccin-mocha)

bind alt-backspace backward-kill-word
