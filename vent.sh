#!/bin/bash
# minecraft server selft-destruct script

# WARNING do not execute unless you want to delete your server

# read server files
source server.settings
source server.functions

# safety checks
RootSafety
ScriptSafety

# parse arguments
ParseArgs "$@"

# debug
Debug "executing $0 script"

# change to server directory
ChangeServerDirectory

# check for existance of executable
CheckExecutable

# look if server is running
CheckScreen

# user safety function for confirmation
Print "warn" "are you sure you want to vent your server?"
read -p "if so, please type ${red}confirm venting${noColor} "
if [[ ${REPLY} == "confirm venting" ]]; then
	Print "info" "you confirmed venting - server will self-destruct now"
else
	Print "error" "wrong token - please try again"
	exit 1
fi

# prints countdown to screen
Countdown "self-destructing"

# game over
Screen "tellraw @a [\"\",{\"text\":\"[Script] \",\"color\":\"blue\"},{\"text\":\"GAME OVER\",\"color\":\"red\"}]"

# server stop
Stop

# awaits server stop
AwaitStop

# force quit server if not stopped
ForceQuit

cd "${homeDirectory}"
# remove crontab
crontab -r
# remove serverdirectory
Print "info" "deleting server..."
rm -r "${serverName}"
# check if vent was successful
if ! [ -d "${serverDirectory}" ]; then
	# game over terminal screen
	GameOver
else
	# error if serverdirectory still exists
	Print "error" "venting failed!"
	exit 1
fi

# debug
Debug "executed $0 script"

# exit with code 0
exit 0
