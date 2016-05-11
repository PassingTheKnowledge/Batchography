@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:main
	setlocal enabledelayedexpansion

	rem set /p str=Enter a string:
	set str=A string is 123

	for /l %%a in (0,1,4096) do (
		set char_i=!str:~%%a,1!
		if not defined char_i goto break
		echo char[%%a] is '!char_i!'
	)
	:break
	echo Done!

	goto :eof