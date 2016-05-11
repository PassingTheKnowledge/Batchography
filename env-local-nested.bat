@echo off

	:: Illustrates how environment localization can be nested
	setlocal

	set v1=1234
	call :f1

	echo v1=%v1%
	echo v2=%v2%

	goto :eof


:f1
	echo f1.v1=%v1%
	setlocal
	set v2=123
	echo f1.v2=%v2%
	endlocal
	echo 'f1.v1=%v1%
	echo 'f1.v2=%v2%

	goto :eof
