@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:main

	setlocal enabledelayedexpansion

	set /p str=Enter a string:
    call :str-len %str%

	echo result=%errorlevel%

	endlocal

goto :eof

:str-len string
    setlocal
	set len=0
	set str=%~1
	:str-len-repeat-1
		if not defined str goto strlen-break-1
		set str=%str:~1%
		set /a len+=1
		goto str-len-repeat-1

	:strlen-break-1
		exit /b %len%
	goto :eof
