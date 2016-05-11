@echo off

setlocal

ECHO Delimit with "," only:
ECHO ----------------------
ECHO.
for /f "delims=, tokens=1-3" %%a in (text-delims-1.txt) DO (
	ECHO #1=[%%a] #2=[%%b] #3=[%%c]
)

ECHO.
ECHO Delimit with "," or ";"
ECHO -------------------------
ECHO.
for /f "tokens=1-3 delims=,;" %%a in (text-delims-2.txt) DO (
	ECHO #1=[%%a] #2=[%%b] #3=[%%c]
)

ECHO.
ECHO Delimit using the inverted question mark
ECHO -----------------------------------------
ECHO.
for /f "tokens=1 delims=¿;" %%a in (text-delims-3.txt) DO (
	ECHO ^<%%a^>
)

ECHO.
ECHO Tokenizing everything into one variable
ECHO -----------------------------------------
ECHO.
for /f "tokens=*" %%a in (text-delims-3.txt) DO (
	ECHO ^<%%a^>
)


ECHO.
ECHO Tokenizing with uppercase L
ECHO ----------------------------
ECHO.
for /f "tokens=1-5 delims=L" %%a in (text-delims-4.txt) DO (
	ECHO ^<%%a %%b %%c %%d %%e^>
)

endlocal