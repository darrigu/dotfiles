hook global BufCreate .*\.bee$ %{
   set-option buffer filetype bee
}

hook global WinSetOption filetype=bee %{
   require-module c-family
}

hook -group bee-highlight global WinSetOption filetype=bee %{
   add-highlighter window/bee ref c
   hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/bee }
}
