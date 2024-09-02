#!/bin/zsh

function gen_workspaces()
{
	i3-msg -t get_tree | jq -r '.nodes.[].nodes[].nodes[] | select(.nodes | length > 0) | .name + ": " + .nodes[0].window_properties.class | tostring'| sort -n
}


WORKSPACE=$( (gen_workspaces)  | rofi -dmenu -p "Select workspace:")

if [ x"empty" = x"${WORKSPACE}" ]
then
    i3_empty_workspace.sh
elif [ -n "${WORKSPACE}" ]
then
	ws=$(echo $WORKSPACE | awk -F: '{print $1}')
    i3-msg workspace "${ws}"
fi
