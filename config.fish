if status is-interactive
    set fish_greeting

    fish_config theme choose "Catppuccin Mocha"
end

set -gx C_INCLUDE_PATH /usr/lib/erlang/usr/include
set -gx EDITOR kak
set -gx CSC_OPTIONS -strict-types

fish_add_path ~/third_party/elixir-ls
fish_add_path ~/.cache/rebar3/bin
fish_add_path ~/.local/bin
fish_add_path ~/.roswell/bin
fish_add_path ~/.config/v-analyzer/bin

alias nv nvim
alias k kak
