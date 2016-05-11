@echo off
:main
	setlocal
	call :add 1 5
	echo The result is %errorlevel%
	goto :eof

:: Add two numbers
:add (num1, num2)
	SET /A result=%1+%2
	exit /b %result%
