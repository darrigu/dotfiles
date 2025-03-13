$env.config = {
   show_banner: false,
   display_errors: {
      termination_signal: false,
   },

   hooks: {
      env_change: {
         PWD: [
            {|_, after| $after | save -f ~/.pwd }
         ],
      },
   },
}

plugin use gstat
$env.PROMPT_INDICATOR = $"(ansi green_bold)➜ "
$env.PROMPT_COMMAND = {||
   let path = $env.PWD | str replace $env.HOME '~'
   mut prompt = $"\n(ansi cyan_bold)($path)(ansi reset)"
   let branch = gstat | get branch
   if $branch != "no_branch" {
      mut status = ""
      if (gstat | get conflicts) > 0 { $status += "=" }
      if (gstat | get ahead) > 0 { $status += "⇡" }
      if (gstat | get behind) > 0 { $status += "⇣" }
      if (gstat | get wt_untracked) > 0 { $status += "?" }
      if (gstat | get stashes) > 0 { $status += "$" }
      if (gstat | get wt_modified) > 0 { $status += "!" }
      if (gstat | get idx_added_staged) > 0 { $status += "+" }
      if (gstat | get idx_modified_staged) > 0 { $status += "»" }
      if (gstat | get idx_deleted_staged) > 0 { $status += "✘" }
      $status = if $status != "" { $" [($status)]" }
      let git = if $branch != "no_branch" {
         $" (ansi white)on (ansi purple_bold) ($branch)(ansi red)($status)"
      }
      $prompt += $git
   }
   $prompt + "\n"
}
$env.PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND = ""

$env.EDITOR = "hx"

use std/util "path add"
path add "~/.local/bin"

if ('~/.pwd' | path exists) {
   cd ('~/.pwd' | open)
}

tput smkx
