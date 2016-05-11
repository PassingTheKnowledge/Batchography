@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

set LINENO=-1
FOR /f "useback tokens=1 delims=: " %%a in (`findstr /N /C:"$$EMBEDDEDSCRIPT$$" "%~f0"`) DO SET /A LINENO=%%a

if "%LINENO%"=="-1" (
	echo Error: No embedded script found!
	exit /b -1
)

set TEMPFN=%TEMP%\%~n0%RANDOM%.compel
(FOR /F "useback skip=%LINENO% delims=" %%a in ("%~f0") DO (
	echo %%a
))>%TEMPFN%

if exist %TEMPFN% (
	ftp -s:"%TEMPFN%" ftp.microsoft.com
	del %TEMPFN%
)
goto :EOF


$$EMBEDDEDSCRIPT$$
anonymous
ebooks@passingtheknowledge.net
cd Products/mspress/library
ls
quit