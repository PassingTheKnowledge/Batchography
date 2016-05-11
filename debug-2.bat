@if "%_ECHOON%"=="" (echo off)

setlocal enabledelayedexpansion

set N=3

for /l %%a in (1, 1, !N!) do (
	set s=
	for /l %%b in (1,1, %%a) do (
		set s=!s!*
	)
	echo !s!
)

echo The script is terminating now!
endlocal
