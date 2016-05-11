@echo off

setlocal enabledelayedexpansion

ECHO /F switch with quotes
ECHO -----------------------
ECHO.
FOR /F "tokens=1-2" %%a IN ("the long text file name.txt") DO (
	echo Line: %%a %%b
)

ECHO usebackq #1
ECHO -------------
ECHO.
FOR /F "usebackq tokens=1-2" %%a IN ("the long text file name.txt") DO (
	echo Line: %%a %%b 
)

ECHO usebackq #2
ECHO -------------
ECHO.
FOR /F "usebackq tokens=1-2" %%a IN ("the long text file name.txt" text1.txt "the long text file name 2.txt") DO (
	echo Line: %%a %%b 
)

endlocal