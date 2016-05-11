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
	set %~2=%~t1
	exit /b 0