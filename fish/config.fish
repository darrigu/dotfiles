set fish_greeting

set -gx EDITOR hx
set -gx FZF_DEFAULT_OPTS "--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,selected-bg:#45475a --multi"
set -gx OAK_STD_PATH ~/projects/oak/std
set -gx GOHOME ~/third_party/go
set -gx PKG_CONFIG_PATH "$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig"

set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
   set -gx PATH "$PNPM_HOME" $PATH
end

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/gem/ruby/3.3.0/bin
fish_add_path ~/projects/oak/bin
fish_add_path ~/third_party/c3
fish_add_path ~/third_party/uxn
fish_add_path ~/.spicetify

alias cd z
alias v nvim
alias ng "nvim +Neogit"

nvm use latest --silent

function starship_transient_prompt_func
   starship module character
end
starship init fish | source
enable_transience

zoxide init fish | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $HOME/.ghcup/bin $PATH

test -r "$HOME/.opam/opam-init/init.fish" && source "$HOME/.opam/opam-init/init.fish" > /dev/null 2> /dev/null; or true

status is-interactive; and theme_gruvbox light

function toggle_fg_bg
   if jobs | grep -q "stopped"
      fg >/dev/null 2>&1
   else
      commandline -f cancel
      commandline "fg"
      commandline -f execute
   end
end

bind \cz toggle_fg_bg
