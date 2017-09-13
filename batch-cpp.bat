/* 2>nul && echo | set /p=
@echo off
setlocal
echo.                                                                                                     
::
:: Self-compiling C++ Batch file!
::
:: (c) Batchography book - by Elias Bachaalany
::

set outfile="%~dpn0.exe"

cl %~dpf0 /TP /EHsc /link /out:%outfile% /nologo > nul

if exist %outfile% (
    %outfile%
    del %outfile%
    del "%~dpn0.obj"
) else (
  echo Compilation failed!
)
goto :eof
*/

#include <stdio.h>

int main()
{
    printf(
    	"Hello world! I was self-compiled!\n"
        "\n"
        "Checkout the Batchography book!\n");
    
    return 0;
}
