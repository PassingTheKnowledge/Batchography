@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal
	call :add-two 5 10
	echo Result=%errorlevel%
	goto :end

:add-two <1=num1> <2=num2> => result => %errorlevel%
	set addtwo.n1=%1
	set addtwo.n2=%2
	set /A addtwo.result="%addtwo.n1% + %addtwo.n2%"
	
	exit /b %addtwo.result%

:end
	endlocal