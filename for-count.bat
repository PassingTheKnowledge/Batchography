@echo off

if "%3"=="" (
	echo Usage: %~n0 start end step
	goto :eof
)

FOR /L %%i IN (%1, %3, %2) DO (
	ECHO i=%%i
)