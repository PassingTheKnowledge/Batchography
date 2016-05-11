@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:main
	echo Starting...

	call :sigma 1 4
	echo Sigma^(1, 4^)=%result%

	call :sigma
	echo Sigma^(,^)=%result%
	
	goto end

:: Sorts an input file into an output file in ascending order.
:: If you pass the optional third argument then descending 
:: order will take place.
:sort-file <1=input file> <2=output file> <3=optional: DESC>
	echo Sorting file...
	goto :eof

:: Computes the total sum of numbers between the start and end numbers
:sigma <1=start number> <2=end number> => %result%
	if "%1"=="" goto sigma-usage
	if "%2"=="" goto sigma-usage

	setlocal

	:: start of counter
	set /a i=%1
	set /a sum=0

	:sigma-repeat
		:: done with the loop
		if %i% GTR %2 goto sigma-break

		set /a sum+=i
		set /a i+=1
		goto sigma-repeat
	
	:sigma-break
		for %%a in (%sum%) do (
			endlocal
			set result=%%a
		)
	goto :eof
	
	:sigma-usage
		endlocal
		set result=Error!
		goto :eof

:end
	rem Cleanup here
	echo Cleaning up....
