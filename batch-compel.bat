@echo off

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
	 ccompel %TEMPFN%
	 del %TEMPFN%
)
goto :EOF

The following is a COMPEL script. COMPEL can be downloaded from here:
- Documentation: http://lallouslab.net/2014/08/29/introducing-compel-a-command-based-interpreter-and-programming-language/
- Source code and binaries: https://github.com/lallousx86/compel/raw/master/BIN/compel_05302006.zip

$$EMBEDDEDSCRIPT$$
var $msg "Hello world from COMPEL!"
echo "$msg"