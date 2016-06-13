@echo off

::
:: (c) Elias Bachaalany <lallousz-x86@yahoo.com>
:: Batchography: The Art of Batch Files Programming
::

setlocal enabledelayedexpansion

title Dynamic menu example - changing console colors interactively

:main
	if "%1"=="print-colors" (
		call :print-color-numbers
		exit /b 0
	)

	call :get-colors-array colors
	:repeat-1
		cls
	
		echo Color names and numbers:
		echo.
		call :display-colors-numbers
		call :get-colors-numbers letters
		set letters=Q%letters%
		
		echo.
		set /p =Enter the foreground followed by the background color number (or press Q to quit): <nul

		:: Select foreground color
		choice /c:%letters% > nul
		set /a fg=%errorlevel%-1
		if %fg%==0 goto break-1
		call set fg=%%letters:~%fg%,1%%
		set /p=%fg% <nul

		:: Select the background color
		choice /c:%letters% > nul
		set /a bg=%errorlevel%-1
		if %bg%==0 goto break-1
		call set bg=%%letters:~%bg%,1%%
		echo %bg%


		call set msg=Changing colors to %%colors.%fg%%% on %%colors.%bg%%%
		set /p "=%msg%" <nul
		for /l %%a in (1,1,3) do (
			timeout /t 1 >nul
			set /p=.<nul
		)
		color %bg%%fg%
		echo.
		goto :repeat-1
	:break-1

	goto :eof

:: Returns all the color numbers
:get-colors-numbers <1=letters>
	setlocal
	set t=
	for /f "usebackq" %%a in (`call "%~f0" print-colors ^| sort`) do (
		set t=!t!%%a
	)
	(
		endlocal
		set %~1=%t%
	)
	goto :eof


:: Display all the color numbers (one color number per line)
:print-color-numbers
	for /f "usebackq tokens=*" %%a in (`color /? ^| findstr /r /C:"[0-9a-f] = "`) do (
		for /f "tokens=1,2,3,4 delims== " %%b in ("%%a") do (
			echo %%b
			echo %%d
		)
	)
	goto :eof

:: Returns an associative array linking the color number to its name
:get-colors-array <1=out-array>
	for /f "usebackq tokens=*" %%a in (`color /? ^| findstr /r /C:"[0-9a-f] = "`) do (
		for /f "tokens=1,2,3* delims== " %%b in ("%%a") do (
			set %1.%%b=%%c
			set %1.%%d=%%e
		)
	)
	goto :eof


:: Displays all the available colors and their names
:display-colors-numbers
	color /? | findstr /r /C:"[0-9a-f] = "
	exit /b 0
