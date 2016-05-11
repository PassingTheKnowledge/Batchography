@echo off

:: 
:: The Batchography book by Elias Bachaalany
::


setlocal enabledelayedexpansion

set /a linecount=0

for /F %%a IN (text1.txt) DO (
	set /a linecount=linecount+1
	ECHO Line #!linecount!: %%a
)

endlocal