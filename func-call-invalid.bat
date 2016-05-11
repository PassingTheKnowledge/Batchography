@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

	echo -- Calling invalid function
	call :function-not-there
	echo After invalid function call --

	echo.
	
	echo -- Calling function1
	call :function1
	echo After function 1 --

	goto :eof

:function1
	echo This is function 1
	rem Return from the function
	goto :eof
