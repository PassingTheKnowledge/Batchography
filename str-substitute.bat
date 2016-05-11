@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

SETLOCAL ENABLEDELAYEDEXPANSION

SET str1=Writing code using the Python scripting language.
ECHO Regular expansion: %str1:Python=Batch%

ECHO With DEVE: !str1:Python=Batch!

ENDLOCAL