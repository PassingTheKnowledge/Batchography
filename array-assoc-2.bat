@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

set FRUITS=k@kiwi$a@apple$b@banana$o@orange

call :get-by-key2 FRUITS a R
echo get-by-key2 result=%R%

call :get-by-key FRUITS b R
echo get-by-key result=%R%


call :get-by-key2 FRUITS a R
echo get by key result=%R%

echo Total encoding
echo -------------------
call :total-encode

echo.
echo Explain
echo -------------------
call :explain

echo.
echo Outer encoding
echo -------------------
call :outer-encode

goto :eof

:: ------------------------------
:old-style
	set FRUITS[b]=banana
	set FRUITS[a]=apple
	set FRUITS[o]=orange
	set FRUITS[k]=kiwi
	goto :eof

:: ------------------------------
:total-encode

	for %%a in (%FRUITS:$= %) do (
		for /f "usebackq tokens=1,2 delims=@" %%b in ('%%a') do (
			echo key=%%b value=%%c
		)
	)

	goto :eof

:: ------------------------------
:outer-encode
	for %%a in ("k=kiwi" "a=apple" "b=banana" "o=orange") do (
		for /f "usebackq tokens=1,2 delims==" %%b in ('%%~a') do (
			echo key=%%b value=%%c
		)
	)

	goto :eof

:explain
	echo FRUITS split by space characters: %FRUITS:$= %

	for %%a in (%FRUITS:$= %) do (
		echo %%a
	)
	goto :eof


:: ------------------------------
:get-by-key <1=assoc-array-name> <2=key> => <3=result>
	setlocal
	call set __t=$%%%~1%%$
	set __t=!__t:*$%~2@=!
	for /f "useback tokens=1* delims=$" %%a in ('%__t%') do (
		endlocal
		set %~3=%%a
	)
	:: Method 1
	rem set __t=!__t:*$%~2@=!&set __t=!__t:$=!
	rem endlocal & set %~3=%__t%
	goto :eof

:: ------------------------------
:get-by-key1 <1=assoc-array-name> <2=key> => <3=result>
	setlocal
	:: Expand the argument value
	call set __t=$%%%~1%%$
	:: Replace left-hand side k/v pairs
	set __t=!__t:*$%~2@=!
	:: Trim trailing k/v pairs
	set __t=!__t:*$%~2@=!&set __t=!__t:$=!
	endlocal & set %~3=%__t%
	goto :eof

:: ------------------------------
:get-by-key2 <1=assoc-array-name> <2=key> => <3=result>
	setlocal
	call set __t=$%%%~1%%$
	:: Method 2
	set __t=!__t:*$%~2@=!
	set __t=!__t:$=^&::!
	endlocal & set %~3=%__t%
	goto :eof
