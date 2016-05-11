@echo off

setlocal enabledelayedexpansion

set str=
for /L %%a in (0, 1, 9) do (
	set str=!str!%%a
)

echo str=%str%

endlocal