@echo off
setlocal enabledelayedexpansion

set RESULT=
for %%i in (%*) do set RESULT=!RESULT!%%i
echo %RESULT%

endlocal