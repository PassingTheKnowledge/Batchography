@echo off

:: 
:: The Batchography book by Elias Bachaalany
::


:repeat
    if "%1"=="" goto end
    echo Arg: %1

    SHIFT

    goto repeat

:end
