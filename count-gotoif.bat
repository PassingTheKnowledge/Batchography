@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

SETLOCAL ENABLEEXTENSIONS

:: -----------------
:: Forward counting
:: -----------------

set /A I=1
set /A C=10
echo Counting from %I% to %C%:
echo.

:repeatcount1
	echo i = %I%
	SET /A I+=1
	if %I% GTR %C% goto donecount1

	goto repeatcount1
:donecount1

echo.
echo Done counting forward!

:: -----------------
:: Backward counting
:: -----------------
set /A I=10
set /A C=1
echo Counting from %I% down to %C%:
echo.

:repeatcount2
	echo i = %I%
	SET /A I-=1
	if %I% LSS %C% goto donecount2

	goto repeatcount2
:donecount2

echo.
echo Done counting backwards!


endlocal