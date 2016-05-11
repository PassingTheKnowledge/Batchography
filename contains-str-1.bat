@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

rem Check if a pattern is contained inside a string without using any external commands

:main
	setlocal

	set /p str=Enter text: 
	set /p pattern=Enter pattern: 
	call :str-contains "%str%" "%pattern%"
	echo found = %errorlevel%

	goto :eof

:str-contains <arg1=text> <arg2=pattern> -> errorlevel

	setlocal

	set copy=%~1
	set repl=%~2

	call set copy=%%copy:%repl%=%%

	(
		endlocal
		if "%~1"=="%copy%" (exit /b 0 ) else (exit /b 1)
	)
