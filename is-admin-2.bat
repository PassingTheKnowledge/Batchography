@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set TEMPFN=%WINDIR%\test-admin-%~nx0-%RANDOM%.tmp
copy "%~f0" "%TEMPFN%" /y >nul 2>&1
if %ERRORLEVEL% equ 0 (
	del "%TEMPFN%"
) else (
	echo Requires admin privilege!
	goto end
)
echo The rest of the script goes here...

:end
endlocal