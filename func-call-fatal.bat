@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

call :L1

echo after L1

goto :eof

:L1

  echo Fatal error in L1. Terminating the script!

  call :TermScript 2>nul
  goto :eof


:TermScript
if 
exit /b