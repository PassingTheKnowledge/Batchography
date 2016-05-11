@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion


	set NUMSET=5 1 10 95 17
	set PLANETSET=Mars Jupiter Pluto Earth Saturn

	call :test-contains

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
	call set __V=%%%~1%%
	for %%a in (%__V%) do (
		if %%a EQU %~2 (
			exit /b 1
		)
	)
	set __V=
	exit /b 0
	goto :eof

:set-remove <1=Set name> <2=Value>
	:: Exercise for the user
	echo NOT IMPLEMENTED
	goto :eof

:set-add <1=Set name> <2=Value>
	:: Exercise for the user
	echo NOT IMPLEMENTED
	goto :eof

:set-destroy <1=Set name>
	set %~1=
