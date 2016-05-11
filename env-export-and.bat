@echo off

setlocal

set variable1=1
set variable2=2
set /A result=variable1 + variable2
endlocal & set result=%result%

echo The result is: %result%