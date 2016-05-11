@echo off

setlocal

set /a c=0
for %%a in (t*.bat,*.exe, "my *.txt") do (
	echo found: %%a
	set /a c=c+1
)

echo.
echo Listed in %c% file(s)
endlocal