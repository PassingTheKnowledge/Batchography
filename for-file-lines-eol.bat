@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

ECHO EOL 
ECHO ----------------------
ECHO.
SET Line=1
for /f "eol=; tokens=*" %%a in (text-eol-1.txt) DO (
	ECHO Line^(!Line!^)=%%a
	SET /A Line=Line+1
)

endlocal