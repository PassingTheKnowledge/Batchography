@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:main
	setlocal enabledelayedexpansion

	call :get-ini settings.ini display height result

	echo r=%result%

	call :get-ini settings.ini settings lastsaved result
	echo r=%result%

	goto :eof

:get-ini <filename> <section> <key> <result>

	set %~4=
	setlocal
	set insection=

	for /f "usebackq eol=; tokens=*" %%a in ("%~1") do (
		set line=%%a

		rem We are inside a section, look for the right key
		if defined insection (
			rem Let's look for the right key
			for /f "tokens=1,* delims==" %%b in ("!line!") do (
				if /i "%%b"=="%3" (
					endlocal
					set %~4=%%c
					goto :eof
				)
			)
		)

		rem Is this a section?
		if "!line:~0,1!"=="[" (
			for /f "delims=[]" %%b in ("!line!") do (
				rem Is this the right section?
				if /i "%%b"=="%2" (
					set insection=1
				) else (
					rem We previously found the right section, so just exit when you encounter a new one
					endlocal
					if defined insection goto :eof
				)
			)
		)
	)
	endlocal
