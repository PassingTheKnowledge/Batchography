@echo off


:: 
:: The Batchography book by Elias Bachaalany
::


goto %1 >nul 2>&1 || (
	echo Failed to go to that label!
	goto :eof
)

echo Unreachable code

:ValidLabel
	echo ValidLabel!
	goto :eof