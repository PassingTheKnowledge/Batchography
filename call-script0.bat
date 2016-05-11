@echo off

:: Call the script and invoke a soft quit
call call-script1.bat softquit
echo after script

:: Call the script and have it terminate at its last line
call call-script1.bat hello world
echo after script, default exit

:: Call the script with no arguments, we know it will fail!
call call-script1.bat
echo This line will not execute!