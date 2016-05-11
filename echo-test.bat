:: Basic echo 
echo This line is echoed
@echo This line is not echoed
@echo off
echo I am under echo off
ECHO.
echo me too
@echo on
echo Hello, echo is back on!


:: Echo 2
@echo off
set /p "=hello "<nul
<nul set /p "=world"
