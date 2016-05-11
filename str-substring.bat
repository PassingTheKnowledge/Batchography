@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

SETLOCAL

REM      012345
SET str1=ABCDEF

ECHO The string is: '%str1%'
ECHO [0, 1 ]  = %str1:~0,1%
ECHO [2, 2 ]  = %str1:~2,2%
ECHO [3,   ]  = %str1:~3%
ECHO [-2,  ]  = %str1:~-2%
ECHO [1, -3]  = %str1:~1,-3%

ECHO [1, -2]  = %str1:~1,-2%
ECHO [0, -1]  = %str1:~0,-1%
ECHO [0, -2]  = %str1:~0,-2%

ENDLOCAL