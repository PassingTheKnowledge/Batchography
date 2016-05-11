@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion

	set FN=test.bin
	echo Extracting embedded binary file '%FN%'
	call :extract-embedded-bin "%FN%"

	goto :eof


:extract-embedded-bin <1=OutFileName>
	setlocal

	set MBEGIN=-1
	for /f "useback tokens=1 delims=: " %%a in (`findstr /B /N /C:"-----BEGIN CERTIFICATE-----" "%~f0"`) DO (
		set /a MBEGIN=%%a-1
	)

	if "%MBEGIN%"=="-1" (
		endlocal
		exit /b -1
	)

	:: Delete previous output files
	if exist "%~1.tmp" del "%~1.tmp"
	if exist "%~1" del "%~1"	

	for /f "useback skip=%MBEGIN% tokens=* delims=" %%a in ("%~f0") DO (
		echo %%a >>"%~1.tmp"
	)

	certutil -decode "%~1.tmp" "%~1" >nul 2>&1
	del "%~1.tmp"

	endlocal
	exit /b 0


-----BEGIN CERTIFICATE-----
TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA8AAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5v
dCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAACd3fm32byX5Nm8l+TZvJfk
Nstl5M68l+Q2y2bk0LyX5DbLZOSuvJfkBENc5Nq8l+TZvJbkjbyX5DTrlOXJvJfk
xDDMMNQw3DDkMOww9DD8MAQxDDEUMRwxJDEsMTQxPDFEMUwxVDFcMWQxbDF0MXwx
hDGMMZQxnDGkMawxtDG8McQxzDHUMdwx5DHsMfQx/DEEMgwyFDIcMiQyLDI0Mjwy
RDJMMlQyXDJkMmwydDJ8MoQyjDKUMpwypDKsMrQyvDLEMswy1DLcMuQy7DL0Mvwy
BDMMMxQzHDMkMywzNDM8M0QzTDNUM1wzZDNsM3QzfDOEM4wzlDOcM6QzrDO0M7wz
AAAAAAAAAAAAAAAAAAAAAA==
-----END CERTIFICATE-----
