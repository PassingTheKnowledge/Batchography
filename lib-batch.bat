:: 
:: Batchography book by Elias Bachaalany
::

:: =====================================================================
:function-dispatcher
	setlocal
	set function=
	if /I "%1"=="volserial"		set function=volserial
	if /I "%1"=="is-odd" 		set function=is-odd
	if /I "%1"=="strlen" 		set function=strlen
	if /I "%1"=="get-tempfile"	set function=get-tempfile

	if not defined function (
		echo FATAL ERROR: Invalid function call '%1'
		endlocal
		exit /B
	)
	
	shift
	(
		endlocal
		goto %function%-function
	)

:: =====================================================================
:get-tempfile-function <1=prefix> <2=extension> <3=out-temp-filename>
	setlocal
	:get-tempfile-repeat
		set FN=%TEMP%\%~1-%RANDOM%.%~2
		if exist "%FN%" goto get-tempfile-repeat

	(
		endlocal
		set %3=%FN%
	)

	goto :eof

:: =====================================================================
:volserial-function <1=drive letter> <2=result-variable>
	for /f "usebackq skip=1 tokens=5" %%a in (`vol %1:`) do (
		endlocal
		set %2=%%a
	)
	goto :eof

:: =====================================================================
:: Check if a number is odd. Test its LSB.
:is-odd-function => errorlevel
	set /A RESULT="(%1 & 1)"
	exit /B %result%

:: =====================================================================
:: Compute a string's length
:strlen-function <1=string> => errorlevel
    setlocal enabledelayedexpansion
    set "s=%~1."
    set len=0
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            set "s=!s:~%%P!"
        )
    )

    ( 
        endlocal
        exit /b %len%
    )	
