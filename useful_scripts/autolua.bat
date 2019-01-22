@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:: Auto interpret LUA scripts
::

:main
    setlocal

    if "%1"=="" goto :help
    if not exist "%1" (
        echo Input file '%1' not found
        goto :eof
    )

    set FN=%1
    set last_fdate=x

    title Batchography - LUA auto re-interpreting '%FN%'

    :repeat
        :: Get the file date/time (incl. seconds)
        for /f "delims=" %%i in ('"forfiles /m %FN% /c "cmd /c echo @ftime" "') do set fdate=%%i

        :: Different attributes found?
        if not "%last_fdate%"=="%fdate%" (
            cls
            echo ftime=%fdate%
            :: Re-interpret
            call C:\LUA\bin\lua.exe "%FN%"
        )

        :: Remember the new date/time
        set last_fdate=%fdate%

        :: Wait for a second before checking for the file modification again
        CHOICE /T 1 /C "yq" /D y > nul

        :: User pressed Q? just quit
        if "%errorlevel%" neq "1" goto :eof

        :: Repeat until user quits or Ctrl-C
        goto repeat

:help
    echo Auto LUA file reinterpreter takes the input file name to auto interpret as an argument
    goto :eof
