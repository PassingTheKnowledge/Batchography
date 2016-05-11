@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion

	set /P str=Please enter a string:

	call :upper2lower "%str%" lower
	echo Converted to all lowercase ^>^> %lower%

	call :lower2upper "%str%" upper
	echo Converted to all uppercase ^>^> %upper%

	call :upper2lower "%upper%" result
	if not "%lower%"=="%result%" (
		echo Something wrong inside the functions!
		goto :eof
	)

	goto :eof

:upper2lower <1=str> <2=result-var>
	setlocal

	set V=%~1

	for %%a in ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" 
			"G=g" "H=h" "I=i" "J=j" "K=k" "L=l" 
			"M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" 
			"T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO (
		for /f "usebackq tokens=1,2 delims==" %%b in ('%%~a') DO (
			set V=!V:%%b=%%c!
		)
	)
	(
		endlocal
		set %~2=%V%
	)

	goto :eof

:lower2upper <1=str> <2=result-var>
	setlocal

	set V=%~1

	for %%a in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" 
			"h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" 
			"o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" 
			"u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO (
		for /f "usebackq tokens=1,2 delims==" %%b in ('%%~a') DO (
			set V=!V:%%b=%%c!
		)
	)
	(
		endlocal
		set %~2=%V%
	)

	goto :eof
