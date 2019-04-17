@echo off
if "%1"=="" (
    call "%~dp0autox.bat"
    goto :eof
)
call "%~dp0autox.bat" "%COMSPEC%" "Batch" /cmdargs "/c" %*
