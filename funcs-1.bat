@echo off

	call :function1
	call :function2 arg1 arg2

	goto :eof

:function1
	echo This is function 1
	rem Return from the function
	goto :eof

:function2
	echo Inside function 2
	echo The arguments are: %*
	goto :eof
