@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion


	set NUMSET.5=1
	set NUMSET.1=1
	set NUMSET.10=1
	set NUMSET.95=1
	set NUMSET.17=1

	set PLANETSET.Mars=1
	set PLANETSET.Jupiter=1
	set PLANETSET.Pluto=1
	set PLANETSET.Earth=1
	set PLANETSET.Saturn=1

	call :set-add NUMSET 66
	call :test-contains

	call :set-destroy PLANETSET

	goto :eof

:test-contains

	:repeat-n-set
	set /P N=Enter a number to see if it is in the set: 
	call :set-contains NUMSET %N%
	if %errorlevel% EQU 1 (
		echo '%N%' is in the set!
	) else (
		echo '%N%' is NOT in the set!
		goto repeat-n-set
	)

	:repeat-p-set
	set /P P=Enter planet name to see if it exist in the set:
	call :set-contains PLANETSET %P%
	if %errorlevel% EQU 1 (
		echo '%P%' is in the set!
	) else (
		echo '%P%' is NOT in the set!
		goto repeat-p-set
	)

	goto :eof


:set-contains <1=Set name> <2=Value>
	if defined %~1.%~2 (exit /b 1) else (exit /b 0)

:set-remove <1=Set name> <2=Value>
	set %~1.%~2=
	goto :eof

:set-add <1=Set name> <2=Value>
	set %~1.%~2=1	
	goto :eof

:set-destroy <1=Set name>
	for /f "usebackq" %%a in (`set %~1.`) do (
		for /f "usebackq tokens=1 delims==" %%b in ('%%a') do (
			set %%b=
		)
	)