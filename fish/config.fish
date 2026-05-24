if status is-interactive
and not set -q TMUX
    exec tmux -u new -A -D -t default
end

set fish_greeting

set -gx --prepend PATH "$HOME/.asdf/shims"

if status is-interactive
    bind alt-backspace backward-kill-word

    fish_config theme choose catppuccin-mocha
    command -q vivid && set -gx LS_COLORS (vivid generate catppuccin-mocha)
end
