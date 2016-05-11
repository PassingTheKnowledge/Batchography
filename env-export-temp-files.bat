@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set variable1=1
set variable2=2

set /A result=variable1 + variable2

echo set result=%result% >%~dpn0-state.bat

endlocal

call %~dpn0-state.bat
del %~dpn0-state.bat
