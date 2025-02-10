#!/usr/bin/env bash
sed -n '/KEYBINDINGS/,/Switchers/p' .config/xmonad/xmonad.hs | grep -e ', ("' -e '\[ ("' -e 'KB_group' | sed -e 's/^[ \t]*//' -e 's/, (/(/' -e 's/\[ //' -e 's/-- KB_group /\n\t/' -e 's/, .*-- /\t/' -e 's/\("[^"]*"\)\([^"]*\)/\1\)\2/' -e 's/"//g' 
