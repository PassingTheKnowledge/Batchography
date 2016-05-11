@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

REM Single loop method
SET /A Total=0
for /F "skip=1 tokens=2 delims=," %%a in (expenses.csv) do (
	set /a Total=Total+%%a
)

echo Total = %Total%
echo.

REM Nested loop demo
SET /A Total=0
for /F "skip=1 tokens=*" %%a in (expenses.csv) do (
	for /f "tokens=2 delims=," %%b in ("%%a") do (
		set /a Total=Total+%%b
	)
)

echo Total = %Total%