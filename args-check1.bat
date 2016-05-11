@echo off

:main
	if "%1"=="" goto Usage
	if "%1"=="compress" goto compress
	if "%1"=="uncompress" goto uncompress

	rem Unknown command passed, display the usage!
	echo Unknown command '%1'!!
	goto usage

:Usage
	ECHO %0 compress^|uncompress archive.zip
	goto end

:compress
	if "%2"=="" (
		echo No archive name was passed!
		goto Usage
	)

	echo Compressing current folder into archive '%2'
	REM invoke the compression utility
	goto end

:uncompress
	if "%2"=="" goto Usage
	if "%2"=="" (
		echo No archive name was passed!
		goto Usage
	)

	if not exist %2 (
		ECHO The archive '%2' is not found!
		goto end
	)
	echo Uncompressing the archive '%2' into the current folder
	REM invoke the decompression utility
	goto end

:end	