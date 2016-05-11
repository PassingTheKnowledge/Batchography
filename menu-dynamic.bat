@echo off
:: 
:: The Batchography book by Elias Bachaalany
::
	setlocal enabledelayedexpansion

:Main
	:: Build the menu one time
	call :Build-Menu "MyMainMenu" MainMenu

:ShowMainMenu	
	echo.
	echo ------------------
	echo Dynamic menus app
	echo ------------------
	echo.
	call :Display-Menu MainMenu "Please make a selection" R1
	
	call %R1%

	goto ShowMainMenu



:: Build the menu
:Build-Menu <1=Menu-Prefix> <2=MenuVar-Out>
	set nmenu=1
	for /F "tokens=1*" %%a in ('findstr /c:":%~1-" /b "%~f0"') do (
		set Menu-%~2-N[!nmenu!]=%%a
		set Menu-%~2-Text[!nmenu!]=%%b

		set /A nmenu+=1
	)

	set /a Menu%~2=%nmenu%-1

	set nmenu=
	
	:: Return the number of menu items built
	exit /b %nmenu%

:: Show a menu
:Display-Menu <1=MenuVar-In> <2=Prompt-Text> <3=Dispatch-Label-Out>
	setlocal
	set choices=
	for /l %%a in (1, 1, !Menu%~1!) do (
		for /f "tokens=2 delims=-" %%b in ("!Menu-%~1-N[%%a]!") do (
			set choice=%%b
			set choices=!choices!!choice!
		)
		echo ^!choice!^) !Menu-%~1-Text[%%a]!
	)
	choice /C:%choices% /M "%~2"
	(
		endlocal
		set %~3=!Menu-%~1-N[%errorlevel%]!
		exit /b 0
	)


:MyMainMenu-A Show app store apps
 	tasklist /apps
 	echo.
 	pause
	exit /b 0

:MyMainMenu-D Display date/time
	echo %DATE% %TIME%
	echo.
	pause
	exit /b 0

:MyMainMenu-B Launch web browser
	start http://www.passingtheknowledge.net/
	exit /b 0

:MyMainMenu-Q Quit
	echo Thanks for using this script!
	echo.
	pause
	call :TermScript 2>nul

:TermScript
	endlocal
	if