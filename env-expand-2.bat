@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set VARNAME=Name
set Name=Albert

echo The variable name is '%VARNAME%
echo Single level: the variable value designated by VARNAME is: '%%%VARNAME%%%'
call echo Two levels: The variable value designated by VARNAME is: '%%%VARNAME%%%'