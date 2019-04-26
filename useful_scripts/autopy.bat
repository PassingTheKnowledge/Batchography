@echo off
if "%1"=="" (
    call "%~dp0autox.bat"
    goto :eof
)
call "%~dp0autox.bat" "c:\Python27\python.exe" "Python" %*