# Catppuccin Mocha

declare-option str rosewater 'rgb:f5e0dc'
declare-option str flamingo 'rgb:f2cdcd'
declare-option str pink 'rgb:f5c2e7'
declare-option str mauve 'rgb:cba6f7'
declare-option str red 'rgb:f38ba8'
declare-option str maroon 'rgb:eba0ac'
declare-option str peach 'rgb:fab387'
declare-option str yellow 'rgb:f9e2af'
declare-option str green 'rgb:a6e3a1'
declare-option str teal 'rgb:94e2d5'
declare-option str sky 'rgb:89dceb'
declare-option str sapphire 'rgb:74c7ec'
declare-option str blue 'rgb:89b4fa'
declare-option str lavender 'rgb:b4befe'
declare-option str text 'rgb:cdd6f4'
declare-option str subtext1 'rgb:bac2de'
declare-option str subtext0 'rgb:a6adc8'
declare-option str overlay2 'rgb:9399b2'
declare-option str overlay1 'rgb:7f849c'
declare-option str overlay0 'rgb:6c7086'
declare-option str surface2 'rgb:585b70'
declare-option str surface1 'rgb:45475a'
declare-option str surface0 'rgb:313244'
declare-option str base 'rgb:1e1e2e'
declare-option str mantle 'rgb:181825'
declare-option str crust 'rgb:11111b'

set-face global title  "%opt{text}+b"
set-face global header "%opt{subtext0}+b"
set-face global bold   "%opt{maroon}+b"
set-face global italic "%opt{maroon}+i"
set-face global mono   %opt{green}
set-face global block  %opt{sapphire}
set-face global link   %opt{blue}
set-face global bullet %opt{peach}
set-face global list   %opt{peach}

# set-face global Default            "%opt{text},%opt{base}"
set-face global Default            %opt{text}
set-face global PrimarySelection   "%opt{text},%opt{surface2}"
set-face global SecondarySelection "%opt{text},%opt{surface2}"
set-face global PrimaryCursor      "%opt{crust},%opt{rosewater}"
set-face global SecondaryCursor    "%opt{text},%opt{overlay0}"
set-face global PrimaryCursorEol   "%opt{surface2},%opt{lavender}"
set-face global SecondaryCursorEol "%opt{surface2},%opt{overlay1}"
# set-face global LineNumbers        "%opt{overlay1},%opt{base}"
set-face global LineNumbers        %opt{overlay1}
# set-face global LineNumberCursor   "%opt{rosewater},%opt{surface2}+b"
set-face global LineNumberCursor   %opt{rosewater}
# set-face global LineNumbersWrapped "%opt{rosewater},%opt{surface2}"
set-face global LineNumbersWrapped %opt{rosewater}
set-face global MenuForeground     "%opt{text},%opt{surface1}+b"
set-face global MenuBackground     "%opt{text},%opt{surface0}"
set-face global MenuInfo           "%opt{crust},%opt{teal}"
set-face global Information        "%opt{crust},%opt{teal}"
set-face global Error              "%opt{crust},%opt{red}"
set-face global StatusLine         "%opt{text},%opt{mantle}"
set-face global StatusLineMode     "%opt{crust},%opt{yellow}"
set-face global StatusLineInfo     "%opt{crust},%opt{teal}"
set-face global StatusLineValue    "%opt{crust},%opt{yellow}"
set-face global StatusCursor       "%opt{crust},%opt{rosewater}"
set-face global Prompt             "%opt{teal},%opt{base}+b"
# set-face global MatchingChar       "%opt{maroon},%opt{base}"
set-face global MatchingChar       %opt{maroon}
# set-face global Whitespace         "%opt{overlay1},%opt{base}+f"
set-face global Whitespace         %opt{overlay1}
set-face global WrapMarker         Whitespace
# set-face global BufferPadding      "%opt{base},%opt{base}"
set-face global BufferPadding      %opt{base}

set-face global value         %opt{peach}
set-face global type          %opt{blue}
set-face global variable      %opt{text}
set-face global module        %opt{maroon}
set-face global function      %opt{blue}
set-face global string        %opt{green}
set-face global keyword       %opt{mauve}
set-face global operator      %opt{sky}
set-face global attribute     %opt{green}
set-face global comment       %opt{overlay0}
set-face global documentation comment
set-face global meta          %opt{yellow}
set-face global builtin       %opt{red}
