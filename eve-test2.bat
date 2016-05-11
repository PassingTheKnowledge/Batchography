@echo off

	set value=1

:repeat
	echo value is '%value%'

	if "%value%"=="1" set value=2
	if "%value%"=="2" set value=3
	if "%value%"=="3" goto end

	goto repeat
:end

	echo Done!