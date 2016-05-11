@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

set L=rarlst.lst
set A=archive.rar

if exist %A% del %A%

git ls-files >%L%

"c:\Program Files\WinRAR\rar.exe" a %A% @%L%

if exist %L% del %L%