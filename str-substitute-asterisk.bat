@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

for %%a in (
	"01:31:2016 at 4:17AM - LOGENTRY: User 'Jane' has logged in"
	"01:31:2016 at 4:17AM - LOGENTRY: File 'payroll.db' has been accessed"
	"01:31:2016 at 4:55AM - LOGENTRY: User 'Jane' logged out"
	) do (
	set V=%%~a
	set V=!V:*LOGENTRY: =!
	echo !V!
)	

endlocal