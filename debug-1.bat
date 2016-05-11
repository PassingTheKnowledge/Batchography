setlocal

:: statement #1
if "%1"=="" (
	echo ^>^>no argument
	echo ^>^>was passed
) else (
	echo ^>^>argument passed!
)

echo ^>^>this is 2nd statement

if "%2"=="" echo ^>^>no second argument passed && goto :eof

echo this is 3rd statement
rem check the third argument
if "%3"=="" (
	echo ^>^>3rd arg not passed
) else (
	echo ^>^>1
	if "%3"=="abc" (
		echo ^>^>abc
	)
)