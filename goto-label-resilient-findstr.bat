@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

if "%1"=="" (
	echo  No label passed, please pass a label name
	goto :eof
)

findstr /X /C:":%~1" "%~f0">nul && goto %~1 || (
	echo The label "%~1" does not exist!
	exit /b -1
)

goto :eof

:mylabel1
	echo this is mylabel1
	goto :eof

:mylabel2
	echo this is mylabel2
	goto :eof
