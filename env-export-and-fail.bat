@echo off

set result=
setlocal enabledelayedexpansion

for /l %%a in (1, 1, 5) do (
	set result=%%a
	if "%%a"=="2" (
		endlocal & set result=!result!
		goto :eof
	)
)
