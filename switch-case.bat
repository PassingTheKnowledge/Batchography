@echo off

	setlocal

	set /P N=Enter number:
	call :nested-if
	echo.
	call :switch-case
	echo.
	call :switch-case-combined
	echo.
	call :switch-case-fallthrough

	goto :eof

:nested-if

	echo Nested IFs...

	if %N%==1 (
		echo One
	) ELSE (
		if %N%==2 (
			echo Two
		) ELSE (
			if %N%==3 (
				echo Three
			) ELSE (
				echo Something else
			)
		)
	)

	echo After IFs
	goto :eof

:switch-case

	echo Switch/case

	:: Call and mask out invalid call targets
	call :switch-case-N-%N% 2>nul || (
		:: Default case
		echo Something else
	)
	goto :switch-case-end
	
	:switch-case-N-1
		echo One
		goto :eof

	:switch-case-N-2
		echo Two
		goto :eof

	:switch-case-N-3
		echo Three
		goto :eof

	:switch-case-end
	echo After Switch/case

	goto :eof



:switch-case-combined

	echo Switch/case combined

	:: Call and mask out invalid call targets
	call :switch-case-N-%N% 2>nul || (
		:: Default case
		echo Something else
	)
	goto :switch-case-end
	
	:switch-case-N-1
	:switch-case-N-2
		echo One or two
		goto :eof


	:switch-case-N-3
	:switch-case-N-4
		echo Three or Four
		goto :eof

	:switch-case-end
	echo After Switch/case combined

	goto :eof


:switch-case-fallthrough

	echo Switch/case fallthrough

	:: Call and mask out invalid call targets
	call :switch-case-N-%N% 2>nul || (
		:: Default case
		echo Something else
	)
	goto :switch-case-end
	
	:switch-case-N-1
		echo One 
		:: Fallsthrough

	:switch-case-N-2
		echo Two
		goto :eof

		goto :eof

	:switch-case-end
	echo After Switch/case fallthrough

	goto :eof
