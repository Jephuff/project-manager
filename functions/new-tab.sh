function prj-new-tab () {
	local cmd=""
	local cdto="$PWD"
	local args="$@"

	if [ -d "$1" ]; then
		cdto=`cd "$1"; pwd`
		args="${@:2}"
	fi

	if [ -n "$args" ]; then
		cmd="; $args"
	fi
	if hash terminator 2>/dev/null; then
		terminator --new-tab -x sh -c "cd \"$cdto\"$cmd; bash" &
	elif hash osascript 2>/dev/null; then
		osascript &>/dev/null <<EOF
			tell application "iTerm"
				tell current window
					set newTab to (create tab with default profile)
					tell newTab
						tell current session
							write text "cd \"$cdto\"$cmd"
						end tell
					end tell
				end tell
			end tell
EOF
	fi
}