@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

	if "!%1"=="" (
		echo Please pass a file name
		goto :eof
	)

	call :get-file-size %1
	echo file size = %errorlevel%

	goto :eof


:get-file-size <1=filename>
	exit /b %~z1