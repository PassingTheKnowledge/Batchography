@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion

	for /l %%a in (1, 1, 8) do (
		call :fib %%a
		echo fib^(%%a^)=!errorlevel!
	)

	goto :eof

:fib <1=n> => %errorlevel%
	:: Break recursion when n==0 or n==1
	if %1 LSS 0 (
		echo Error: Cannot be called with a negative number!
		exit /b 0
	)
	if "%1"=="0" exit /b 0
	if "%1"=="1" exit /b 1

	setlocal

	:: r1 = fib(n-1)
	set /a arg=%1-1
	call :fib %arg%
	set r1=%errorlevel%

	:: r2 = fib(n-2)
	set /a arg=%1-2
	call :fib %arg%
	set r2=%errorlevel%

	:: return result
	set /a r=r1+r2
	exit /b %r%