@echo off

:: 
:: (c) The Batchography book by Elias Bachaalany
::

:: Draw the menu
:Show-menu
	echo.
	echo ---------------------------
	echo Interactive Batch file v1.0
	echo ---------------------------
	echo.
	echo 1. Display processes
	echo 2. Kill processes
	echo 3. Other
	echo Q. Quit
	echo.
	choice /c:123Q /M "Please choose an action: "
	echo.

	if %errorlevel%==1 call :Display-processes
	if %errorlevel%==2 call :kill-processes
	if %errorlevel%==3 call :Other

	if %errorlevel%==4 goto Quit

	goto Show-menu


:: Display all the processes that match a criteria
:Display-processes
	setlocal
	set /p m=Enter process name (with extension):
	tasklist /FI "IMAGENAME EQ %m%"
	endlocal
	echo.
	pause
	goto Show-menu


:: Kill processes
:Kill-Processes
	setlocal
	set /p m=Enter process partial name (extension not needed):
	choice /C:YN /M:"All processes matching %m%* will be terminated. Are you sure?"
	if %errorlevel%==1 (
		taskkill /im * /f /fi "imagename eq %m%*"
		pause
	)
	endlocal
	echo.
	exit /b 0


:: Sub menu
:Other
	echo -------
	echo Options
	echo -------
	echo (C) Change console color
	echo (D) Change console window dimensions
	echo (R) Run administrative prompt
	echo.
	echo (B) ^<-- Go back
	choice /c:CDRB /m "Please choose an option:"

	if %errorlevel%==1 call :Change-Color
	if %errorlevel%==2 call :Change-Dimensions
	if %errorlevel%==3 (
		start "" runas /user:Administrator cmd.exe
	)

	exit /b 0


:Display-Colors-Numbers
	for /l %%a in (0, 1, 7) do (
		color /? | findstr /C:"%%a = "
	)
	exit /b 0

:Change-Dimensions
	setlocal
	set /p lines=Enter desired number of lines:
	set /p cols=Enter desired number of columns:
	mode con: cols=%cols% lines=%lines%
	
	endlocal
	exit /b 0

:Change-Color
	call :Display-Colors-Numbers
	
	setlocal
	set /P bg=Select background color number:
	set /P fg=Select foreground color number:
	:: Just take a single digit
	set bg=%bg:~0,1%
	set fg=%fg:~0,1%

	color %bg%%fg%
	endlocal
	exit /b 0
	
::	
:: Quit menu
:Quit
	echo Thanks for using the Interactive Batch file^!
	echo.
	set /p "=This script will terminate in 5 seconds"<nul
	for /l %%a in (1, 1, 5) do (
		set /p "=." <nul
		timeout /t 1 >nul
	)
	exit /b 0
