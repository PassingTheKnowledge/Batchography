@echo off


:: 
:: The Batchography book by Elias Bachaalany
::

:main

	setlocal enabledelayedexpansion

	call :str-len "marco polo" result

	echo result=%result%

	endlocal

goto :eof

:str-len (string, result-var)
	set len=0
	set str=%~1
	:str-len-repeat-1
		if not defined str goto strlen-break-1
		set str=%str:~1%
		set /a len+=1
		goto str-len-repeat-1

	:strlen-break-1
		set %~2=%len%
	goto :eof
