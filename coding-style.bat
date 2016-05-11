@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:start
	rem Usually, parameters are parsed here

	if "%1"=="help" 		goto usage
	if "%1"=="compress" 	goto compress

	goto usage

:usage
	echo.
	echo Example usage:
	echo ----------------
	echo %0 help       - Shows the help screen
	echo %0 compress   - Start the compression
	goto end

:compress
	if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		echo Sorry, this tool requires an x86 operating system
		goto end
	)

	rem Do the compression
	goto end


:end
