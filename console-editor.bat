@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

if "%1"=="" (
	echo Please specify the file name to create.
	goto :eof
)

echo Please start typing. Press Ctrl+Z to finish.

copy CON %1 >nul

echo.
echo Excellent. You typed the following:
if exist %1 type %1