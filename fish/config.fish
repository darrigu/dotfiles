set fish_greeting

if status is-interactive
    bind alt-backspace backward-kill-word

    fish_config theme choose nord
    #command -q vivid && set -gx LS_COLORS (vivid generate catppuccin-mocha)
end
