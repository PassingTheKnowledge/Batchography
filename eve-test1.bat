@echo off

set value=1

if "%value%"=="1" (
	set value=2
	echo The value inside the IF block is '%value%'
)

echo The value after the IF block is '%value%'