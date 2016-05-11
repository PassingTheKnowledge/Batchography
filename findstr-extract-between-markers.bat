@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion

	set FN=findstr-test.txt
	call :get-line-no "//<Begin" "%FN%"
	set MBEGIN=%errorlevel%

	call :get-line-no "//>End" "%FN%"
	set MEND=%errorlevel%
	
	if "%MBEGIN%"=="-1" goto error
	if "%MEND%"=="-1" goto error

	set /A C=MEND-MBEGIN-1

	for /f "useback skip=%MBEGIN% tokens=* delims=" %%a in ("%FN%") DO (
		echo %%a
		SET /A C-=1
		if !C!==0 goto :eof
	)

	goto :eof

:get-line-no <1=string> <2=file>
	for /f "useback tokens=1 delims=:" %%a in (`findstr /N /C:"%~1" "%~2"`) DO EXIT /B %%a
	EXIT /B -1

:error
	echo Could not find markers!
	exit /b	