@echo off

setlocal
	if "!%1"=="" (
		echo Please pass a file name
		goto :eof
	)

	call :get-file-ftime %1 ftime
	echo file time is = %ftime%

	goto :eof


:get-file-ftime <1=filename> <2=result-var>
	setlocal
	set P=%~dp1
	set P=%P:~0,-1%
	for /f "usebackq tokens=* delims=" %%a in (
		`forfiles /P "%P%" /M "%~nx1" /c "cmd /c echo @ftime"`) DO (
			endlocal
			set %~2=%%a
	)
	exit /b 0