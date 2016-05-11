@echo off
setlocal

:repeat
	set input=
	set /p input=enter value: 
	if "%input%"=="" goto :eof
	echo -^> %input%
	goto repeat
	