@echo off

setlocal ENABLEEXTENSIONS

set GodMode=

SET /P Name="Please enter your name: "
IF /I "%Name%" EQU "iddqd" (
	ECHO God mode enabled!
	SET GodMode=1
)

SET /P Age="Please enter your age: "
IF %Age% LSS 18 (
	ECHO Sorry, you're under age...terminating.
	GOTO :EOF
)


if %Age% GEQ 90 (
	if NOT DEFINED GodMode (
		ECHO Whooa, you still have the spirit mortal!
	)
)

echo Let the party begin...
if DEFINED GodMode (
	ECHO !! God mode ON. You earned unlimited free drinks !!
)
endlocal