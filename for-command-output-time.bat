@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

rem Without usebackq
for /f "tokens=1-3 delims=: " %%a in ('time /t') DO (
	echo hour=%%a mins=%%b ampm=%%c
)

rem usebackq
for /f "usebackq tokens=1-3 delims=: " %%a in (`time /t`) DO (
	echo tok1=%%a tok2=%%b tok3=%%c
)

endlocal