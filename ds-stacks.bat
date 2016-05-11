@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

	for /L %%a in (1, 1, 10) DO (
		echo Push %%a
		call :push STK %%a
	)

	echo.
	echo.
	:test-pop-more
		call :pop STK V
		if not defined V goto test-pop-no-more
		echo Pop -^> %V%
		goto test-pop-more
	:test-pop-no-more

goto :eof


:push <1=variable> <2=value> [3=value, 4=value, ...]
	:push-more
		call set %~1=%~2~%%%1%%
		shift /2
		if "%2" NEQ "" goto push-more
	goto :eof

:pop <1=variable> => <2=out-variable>
	:: Clear previous output variable
	set %~2=

	setlocal
	:: Expand the value of the input variable
	call set VAL=%%%~1%%
	:: Tokenize, take two tokens: first token and the remaining ones
	for /F "usebackq tokens=1* delims=~" %%a in ('%VAL%') DO (
		endlocal
		:: Pop off the value
		set %~1=%%b
		:: Return the popped value
		set %~2=%%a
	)

	goto :eof
