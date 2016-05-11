@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:: Clear previous values
set result1=
set result2=

:: Start localization
setlocal

set r1=Hello
set r2=World

:: Compound statement
(
	:: End localization
	endlocal
	set result1=%r1%
	set result2=%r2%
)
