@echo off

setlocal

set variable1=1
set variable2=2

set /A result=variable1 + variable2
exit /B %result%