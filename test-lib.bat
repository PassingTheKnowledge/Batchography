@echo off

setlocal enabledelayedexpansion

for %%a in ("abcdefg~7" "hello world~11" "hello~5" "a~1" "ab~2") do (
	for /f "tokens=1,2 delims=~" %%b in (%%a) do (
		echo Checking length for "%%b"
		call lib-batch strlen "%%b"
		set R=!errorlevel!
		echo Length is: !R! , expected length: %%c
		if !R! NEQ %%c (
		:ErrStrlenfailed
			echo String length function failed.
			EXIT /B -1
		)
	)
)

echo Testing empty string length
call lib-batch strlen
if %errorlevel% neq 0 goto ErrStrlenfailed
echo Empty string length is zero

set Odd=0
FOR /L %%a IN (10, 1, 20) DO (
	call lib-batch is-odd %%a
	set R=!errorlevel!
	echo Is odd '%%a'? =^> !R!
	if !R! NEQ !Odd! (
		echo Odd test failed.
		EXIT /B -1
	)
	if !Odd!==0 (set Odd=1) else (set Odd=0)
)

echo -------------------
echo All tests passed!
echo -------------------