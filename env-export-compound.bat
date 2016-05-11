@echo off

	setlocal
	:: Make sure no result is set previously
	set result1=
	set result2=
	set result3=

	:: Call the function
	call :get-results

	:: Check results
	set result

	goto :eof

:get-results
	setlocal enabledelayedexpansion
	set s=
	for /l %%a in (1, 1, 5) do (
		set s=!s!%%a
		if "%%a"=="4" (
			set /a retval1=!s!
			set /a retval2=%%a * 2
			set /a retval3=%%a * 4
			goto get-result-return
		)
	)
	goto :eof

	:get-result-return
	(
		endlocal
		set result1=%retval1%
		set result2=%retval2%
		set result3=%retval3%
	)