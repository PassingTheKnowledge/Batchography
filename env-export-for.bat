@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set variable1=hello
set variable2=world

set result=%variable1% %variable2%

for /f "usebackq tokens=* delims=" %%a in ('%result%') do (
	endlocal
	set result=%%a
	goto :eof
)