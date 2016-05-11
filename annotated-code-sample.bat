@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

:main
	if exist log.txt del log.txt

	pushd compiler
	if not exist cl.exe (
		echo The compiler was not found!
		goto :end
	)

	cl.exe hello.c

	if %ERRORLEVEL% EQU 0 (
		echo Compilation successful!
	) ELSE (
		echo Compilation failed!
	)

:end
	POPD