@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

whoami.exe /priv | find "SeTakeOwnershipPrivilege" > nul

if errorlevel 1 (
	echo Requires admin!
	goto :eof
)

:start

echo Script running as admin...
