@echo off

:main
	setlocal

	set /p str=Enter a string:

	set i=0
	:repeat
		call set char_i=%%str:~%i%,1%%
		if not defined char_i goto break
		echo char[%i%]=%char_i%
		set /a i+=1
		goto repeat
	:break

	endlocal
	