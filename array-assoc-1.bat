@echo off

setlocal enabledelayedexpansion

set USERS[moeh]=Moe Howard
set USERS[shemph]=Shemp Howard
set USERS[larryf]=Larry Fine

for /f "usebackq delims=" %%a in (`set USERS[`) do (
	for /f "usebackq tokens=1,2 delims==" %%m in ('%%a') do (
		set __k=%%m& set __k=!__k:*[=!& set __k=!__k:]=!
		set __v=%%n
		echo key = '!__k!' value = '!__v!'
	)
)

echo.

set /p user=Enter user name:
if not defined USERS[%user%] (
	echo User '%user%' was not found in the system!
) else (
	echo %user%'s full name is: !USERS[%user%]!
)

endlocal