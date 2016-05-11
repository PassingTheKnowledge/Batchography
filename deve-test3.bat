@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

SETLOCAL ENABLEDELAYEDEXPANSION
SET C=-1
FOR /L %%a IN (1, 1, 4) DO (
	set C=%%a
	echo a=%%a, regular expansion of C=%C% and delayed expansion of C=!C!
)

ECHO After the loop, C=%C%