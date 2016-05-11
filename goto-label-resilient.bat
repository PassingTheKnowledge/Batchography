@echo off

:: with error handling

goto %1 || (
	echo Failed to go to that label!
	goto :eof
)

echo Unreachable code

:ValidLabel
	echo ValidLabel!
	goto :eof