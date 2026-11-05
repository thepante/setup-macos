-- Rex Open: the default app for the source and Markdown files Rex opens on cmd+click.
-- It queues the files for the open_file action in init.lua, then presses F18 in Rex.
-- The app is a stub that runs this file, so editing it keeps the app's signature and
-- the Accessibility grant that goes with it. Build the stub with:
--   osacompile -o ~/Applications/"Rex Open.app" -e 'on open theFiles' -e 'run script (POSIX file ((POSIX path of (path to home folder)) & ".config/rex/open-file.applescript")) with parameters {theFiles}' -e 'end open'

on run {theFiles}
	set paths to ""
	repeat with f in theFiles
		set paths to paths & POSIX path of f & linefeed
	end repeat
	do shell script "mkdir -p ~/.local/state/rex && printf %s " & quoted form of paths & " > ~/.local/state/rex/open-file"
	try
		tell application id "com.superlogical.rex" to activate
		delay 0.2
		tell application "System Events" to key code 79
	on error message
		do shell script "printf '%s\\n' " & quoted form of message & " >> ~/.local/state/rex/open-file.log"
	end try
end run
