@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set statefile=%~dpn0-state.txt

:main
	call :loadvariables "%statefile%"

	:: Initialize variables
	if "%script.inited%" NEQ "1" (
		set script.v1=1
		set script.v2=2
		set script.v3=3
		set script.v4=4
		set script.inited=1
	)

	:: Dump variables after load
	call :dumpvars The loaded script state variables are:

	::decrement and flip
	set /a script.v2=-script.v2
	set /a script.v4-=1

	:: Dump variables after load
	echo.
	call :dumpvars The script state variables at script end:

	:: Save the variables
	call :savevariables "%statefile%" script

	goto :eof


:dumpvars <message*>
	echo.
	echo ---------------------------------------------------
	echo %*
	echo ---------------------------------------------------
	set script.
	goto :eof


:loadvariables <1=statefile>

	if not exist "%~1" goto :eof

	for /f "usebackq" %%a in ("%~1") do (
		set %%a
	)

	goto :eof


:savevariables <1=statefile> <2=state-prefix>
	:: Dump all the state environment variables
	set %2.>"%~1" 2>nul
	goto :eof	
