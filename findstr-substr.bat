@echo off

setlocal enabledelayedexpansion

for /f "useback tokens=*" %%a in (`findstr /b /c:"@" "findstr-test.txt"`) do (
	set line=%%a
	set line=!line:~1!
	echo !line!
)

endlocal