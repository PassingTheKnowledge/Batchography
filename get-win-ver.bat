@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

	call :get-ver vername

	echo Windows version is: "%vername%"
	goto :eof


:get-ver -> %result-var%
	for /f "usebackq tokens=3*" %%a in (`net config workstation ^| findstr /c:"Software version"`) DO (
		set %~1=%%a %%b
	)
	goto :eof