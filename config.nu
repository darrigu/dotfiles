let theme = {
   rosewater: "#f5e0dc"
   flamingo: "#f2cdcd"
   pink: "#f5c2e7"
   mauve: "#cba6f7"
   red: "#f38ba8"
   maroon: "#eba0ac"
   peach: "#fab387"
   yellow: "#f9e2af"
   green: "#a6e3a1"
   teal: "#94e2d5"
   sky: "#89dceb"
   sapphire: "#74c7ec"
   blue: "#89b4fa"
   lavender: "#b4befe"
   text: "#cdd6f4"
   subtext1: "#bac2de"
   subtext0: "#a6adc8"
   overlay2: "#9399b2"
   overlay1: "#7f849c"
   overlay0: "#6c7086"
   surface2: "#585b70"
   surface1: "#45475a"
   surface0: "#313244"
   base: "#1e1e2e"
   mantle: "#181825"
   crust: "#11111b"
}

let scheme = {
   recognized_command: $theme.blue
   unrecognized_command: $theme.text
   constant: $theme.peach
   punctuation: $theme.overlay2
   operator: $theme.sky
   string: $theme.green
   virtual_text: $theme.surface2
   variable: { fg: $theme.flamingo attr: i }
   filepath: $theme.yellow
}

$env.config = {
   show_banner: false,
   display_errors: {
      termination_signal: false,
   },
   color_config: {
      separator: { fg: $theme.surface2 attr: b }
      leading_trailing_space_bg: { fg: $theme.lavender attr: u }
      header: { fg: $theme.text attr: b }
      row_index: $scheme.virtual_text
      record: $theme.text
      list: $theme.text
      hints: $scheme.virtual_text
      search_result: { fg: $theme.base bg: $theme.yellow }
      shape_closure: $theme.teal
      closure: $theme.teal
      shape_flag: { fg: $theme.maroon attr: i }
      shape_matching_brackets: { attr: u }
      shape_garbage: $theme.red
      shape_keyword: $theme.mauve
      shape_match_pattern: $theme.green
      shape_signature: $theme.teal
      shape_table: $scheme.punctuation
      cell-path: $scheme.punctuation
      shape_list: $scheme.punctuation
      shape_record: $scheme.punctuation
      shape_vardecl: $scheme.variable
      shape_variable: $scheme.variable
      empty: { attr: n }
      filesize: {||
         if $in < 1kb {
            $theme.teal
         } else if $in < 10kb {
            $theme.green
         } else if $in < 100kb {
            $theme.yellow
         } else if $in < 10mb {
            $theme.peach
         } else if $in < 100mb {
            $theme.maroon
         } else if $in < 1gb {
            $theme.red
         } else {
            $theme.mauve
         }
      }
      duration: {||
         if $in < 1day {
            $theme.teal
         } else if $in < 1wk {
            $theme.green
         } else if $in < 4wk {
            $theme.yellow
         } else if $in < 12wk {
            $theme.peach
         } else if $in < 24wk {
            $theme.maroon
         } else if $in < 52wk {
            $theme.red
         } else {
            $theme.mauve
         }
      }
      date: {|| (date now) - $in |
         if $in < 1day {
            $theme.teal
         } else if $in < 1wk {
            $theme.green
         } else if $in < 4wk {
            $theme.yellow
         } else if $in < 12wk {
            $theme.peach
         } else if $in < 24wk {
            $theme.maroon
         } else if $in < 52wk {
            $theme.red
         } else {
            $theme.mauve
         }
      }
      shape_external: $scheme.unrecognized_command
      shape_internalcall: $scheme.recognized_command
      shape_external_resolved: $scheme.recognized_command
      shape_block: $scheme.recognized_command
      block: $scheme.recognized_command
      shape_custom: $theme.pink
      custom: $theme.pink
      background: $theme.base
      foreground: $theme.text
      cursor: { bg: $theme.rosewater fg: $theme.base }
      shape_range: $scheme.operator
      range: $scheme.operator
      shape_pipe: $scheme.operator
      shape_operator: $scheme.operator
      shape_redirection: $scheme.operator
      glob: $scheme.filepath
      shape_directory: $scheme.filepath
      shape_filepath: $scheme.filepath
      shape_glob_interpolation: $scheme.filepath
      shape_globpattern: $scheme.filepath
      shape_int: $scheme.constant
      int: $scheme.constant
      bool: $scheme.constant
      float: $scheme.constant
      nothing: $scheme.constant
      binary: $scheme.constant
      shape_nothing: $scheme.constant
      shape_bool: $scheme.constant
      shape_float: $scheme.constant
      shape_binary: $scheme.constant
      shape_datetime: $scheme.constant
      shape_literal: $scheme.constant
      string: $scheme.string
      shape_string: $scheme.string
      shape_string_interpolation: $theme.flamingo
      shape_raw_string: $scheme.string
      shape_externalarg: $scheme.string
   },
   highlight_resolved_externals: true,
   explore: {
      status_bar_background: { fg: $theme.text, bg: $theme.mantle },
      command_bar_text: { fg: $theme.text },
      highlight: { fg: $theme.base, bg: $theme.yellow },
      status: {
         error: $theme.red,
         warn: $theme.yellow,
         info: $theme.blue,
      },
      selected_cell: { bg: $theme.blue fg: $theme.base },
   },

   hooks: {
      pre_prompt: [{ tput smkx }],
      env_change: {
         PWD: [
            {|_, after| $after | save -f ~/.pwd }
         ],
      },
   },
}

plugin use gstat
$env.PROMPT_INDICATOR = { 
   if ($env.LAST_EXIT_CODE == 0) {
      $"(ansi green_bold)➜ "
   } else {
      $"(ansi red_bold)✘ "
   }
}
$env.PROMPT_COMMAND = {||
   let path = $env.PWD | str replace $env.HOME '~'
   mut prompt = $"\n(ansi cyan_bold)($path)(ansi reset)"
   
   let git_status = gstat
   let branch = $git_status | get branch

   if $branch != "no_branch" {
      let status_symbols = [
         (if ($git_status | get conflicts) > 0 { "=" }),
         (if ($git_status | get ahead) > 0 { "⇡" }),
         (if ($git_status | get behind) > 0 { "⇣" }),
         (if ($git_status | get wt_untracked) > 0 { "?" }),
         (if ($git_status | get stashes) > 0 { "$" }),
         (if ($git_status | get wt_modified) > 0 { "!" }),
         (if ($git_status | get idx_added_staged) > 0 { "+" }),
         (if ($git_status | get idx_modified_staged) > 0 { "»" }),
         (if ($git_status | get idx_deleted_staged) > 0 { "✘" })
      ] | filter { |x| $x != "" } | str join ""

      let status = if ($status_symbols | str length) > 0 { $" [($status_symbols)]" } else { "" }
      let git = $" (ansi white)on (ansi purple_bold) ($branch)(ansi red)($status)(ansi reset)"
      $prompt += $git
   }

   let overlays = overlay list | skip 1
   if ($overlays | length) > 0 {
      $prompt += $" (ansi yellow)\(($overlays | str join ' ')\)"
   }

   $prompt + "\n"
}
$env.PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND = ""

$env.EDITOR = "hx"
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
$env.VIRTUAL_ENV_DISABLE_PROMPT = true

alias v = nvim

use std/util "path add"
path add "~/.local/bin"
path add $env.PNPM_HOME

if ('~/.pwd' | path exists) {
   cd ('~/.pwd' | open)
}

use task.nu
