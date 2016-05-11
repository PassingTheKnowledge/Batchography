@echo off

:: Script to illustrate how to export environment variables

	setlocal

	call :get-two-randoms res1 res2
	echo Checking if environment is polluted:
	set v1 & set v2
	echo.
	echo Checking results:
	set res
	goto :eof

:get-two-randoms <1=out1> <2=out2>
	setlocal
	set v1=%RANDOM%
	set v2=%RANDOM%
( 
    endlocal
    set "%~1=%v1%"
    set "%~2=%v2%"
    goto :eof
)