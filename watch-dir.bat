@echo off

:: 
:: (c) The Batchography book by Elias Bachaalany
::
	
	setlocal enabledelayedexpansion

:main
	if "%1"=="" goto Usage
	if "%2"=="" goto Usage

	:: Copy the watch interval
	set /A WatchInterval=%~2

	:: Set default interval to 5 seconds if an invalid value was passed
	if WatchInterval==0 set WatchInterval=5

	:: Set the recursive switch
	if /i "%3"=="/S" set Watch-Recursive=" /S "

	:: Generate temp files
	set BASEFILE=%TEMP%\B%RANDOM%_%RANDOM%.txt
	set CURFILE=%TEMP%\C%RANDOM%_%RANDOM%.txt

	set /p "=Watching the directory %1 every %2 second(s) " <nul
	if DEFINED Watch-Recursive echo ^(recursively^)
	echo.
	echo Press 'Q' to quit at any time.

	call :Watch-Loop "%~1" %~2

	:: Cleanup
	del %BASEFILE% /q >nul 2>&1
	del %CURFILE% /q >nul 2>&1
	goto :eof


:Watch-Loop <1=WatchDir>
	call :Get-State "%~1" "%BASEFILE%" %Watch-Recursive%

	:: Make a choice that times out.
	choice /t %WatchInterval% /c:qc /d c >nul
	if !errorlevel!==1 goto :eof

    call :Get-State "%~1" "%CURFILE%" %Watch-Recursive%

    :: Compare
    fc "%BASEFILE%" "%CURFILE%" >nul
    if "%errorlevel%"=="1" (
    	echo Changes detected on %DATE% %TIME%
    	if exist "%~dp1trigger.bat" call "%~dp1trigger.bat"
	)

    :: Set baseline to be the current state
    move "%CURFILE%" "%BASEFILE%" >nul

	goto Watch-Loop

:Get-State <1=WatchPath> <2=OutStatFileName> <3=ExtraSwitches>
	setlocal
	set P=%~dp1
	set P=%P:~0,-1%
	forfiles /p "%P%" /m *.* %~3 /c "cmd /c echo @relpath @ftime @fdate @fsize @isdir" >%~2

	endlocal
	goto :eof


:Usage
	echo -----
	echo Usage
	echo ------
	echo %~n0 DirectoryToWatch Poll Interval in seconds [/R]
	echo.
	echo Specify the directory to watch.
	echo Optionally pass the /R switch to watch recursively
	echo.
	echo Place a file called 'trigger.bat' in the watch directory to call it on change

	goto :end

:end