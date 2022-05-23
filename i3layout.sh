#!/bin/bash

get_kbdlayout() {
	case "$(xset -q|grep LED| awk '{ print $10 }')" in
	  "00000002") KBD="EN" ;;
	  "00001002") KBD="RU" ;;
	  *) KBD="unknown" ;;
	esac
	echo "$KBD"
}

i3status | while :
  do
    read line
    block="{\"full_text\":\"$(get_kbdlayout)\"}"
    echo "${line/\[\{/\[$block,\{}"|| exit 1
  done
}
