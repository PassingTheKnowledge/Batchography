@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

if "%1"=="" (
	echo FATAL ERROR! No arguments passed!
	:: Terminate the caller as well
	EXIT
)

echo script1 called with: %*

if "%1"=="softquit" (
	:: Terminate this script only
	exit /b
)

:: Even if no EXIT is passed, script will terminate w/o terminating the caller!