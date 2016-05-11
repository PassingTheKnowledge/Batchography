@echo off

setlocal

	if "!%1"=="" (
		echo Please pass a file name
		goto :eof
	)

	call :get-file-attr %1 attr
	echo file attributes are: %attr%

	goto :eof


:get-file-attr <1=filename> <2=result-var>
	set %~2=%~a1
	exit /b 0