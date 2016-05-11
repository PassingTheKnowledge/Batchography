@echo off
setlocal enabledelayedexpansion

set /P "S=Enter string: "
call lib-batch strlen "%S%"
echo The string "%S%" length is %errorlevel%

echo.
set /P "N=Enter number: "
call lib-batch is-odd %N%
if %errorlevel%==1 (echo The number %N% is Odd!) ELSE (echo The number %N% is even!)

echo.
call lib-batch get-tempfile tmpfil tmp S
echo Generated temp file name at: %S%

echo.
set /P "S=Enter drive letter: "
call lib-batch volserial %S% N
echo The volume serial number of drive %S% is: %N%
endlocal