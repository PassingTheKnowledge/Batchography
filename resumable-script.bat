@echo off

:: 
:: from the Batchography book by Elias Bachaalany
::

:prologue
	setlocal enabledelayedexpansion

	::
	:: Initialize global variables here
	::
	set stagesfile=%~dpn0-stages.txt
	set progressfile=%~dpn0-progress.txt
	set exec=

	:: 
	:: The stages file does not exist, create it!
	::
	if not exist "%stagesfile%" (
		findstr /b ":step-" "%~f0">%stagesfile%

		rem Reset progress
		if exist "%progressfile%" del "%progressfile%"
	)

	::
	:: Execute each step in progression
	::

	:: Read the current stagesfile
	if exist "%progressfile%" (
		for /f "usebackq" %%a in ("%progressfile%") do set curstep=%%a
	) else (
		set exec=1
	)

	::
	:: Dispatcher loop
	::
	:: Go over all the stages
	for /f "usebackq" %%a in ("%stagesfile%") do (
		:: Should we execute from here and on?
		if "!exec!"=="1" (
			:: Execute the step
			call %%a

			:: Remember the step as executed
			echo %%a>%progressfile%

			:: Last step? Delete the progress file
			if "%%a"==":step-done" del "%progressfile%"
		) else (
			:: Now that we did not execute this step, signal execution for next step
			if "%%a"=="%curstep%" set exec=1
		)
	)

	:: All done!
	goto :eof

:step-create-files
	echo (1) creating files
	timeout /t 2 >nul
	goto :eof

:step-process-files
	echo (2) processing files
	timeout /t 2 >nul
	goto :eof


:step-create-report
	echo (3) creating report
	timeout /t 2 >nul
	goto :eof

:step-compress
	echo (4) compressing report
	timeout /t 2 >nul
	goto :eof

:step-email
	echo (5) emailing the report
	timeout /t 2 >nul
	goto :eof


:step-done
	echo (6) All steps done! Script terminated!
	goto :eof
