@echo off

setlocal

set /P Fname=Enter your first name:
set /P Lname=Enter your last name:

set FULLNAME=%Fname% %Lname%

echo Full name is: %FULLNAME%