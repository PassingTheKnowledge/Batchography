@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

:: Auto render DOT graphs
::
:: Requires the following tools to be in the PATH environment variable:
::
:: - dot2pic.exe      : https://github.com/lallousx86/GraphViz/raw/master/dot2pic/REL/latest.zip
:: - AutoPicture.exe  : https://github.com/lallousx86/WinTools/raw/master/AutoPicture/REL/latest.zip
::

:main
    setlocal

    if "%1"=="" goto :help
    if not exist "%~1" (
        echo Input file '%1' not found
        goto :eof
    )

    set last_fdate=x

    title Batchography - GraphViz DOT auto rendering '%~1'

    :: Change working directory to that of the input script
    pushd "%~dp1"

    :: Start the auto renderer
    start "autopicture" "%~dp0AutoPicture.exe" "%~dpn1.jpg"
    :repeat
        :: Get the file date/time (incl. seconds)
        for /f "delims=" %%i in ('"forfiles /m "%~nx1" /c "cmd /c echo @ftime" "') do set fdate=%%i

        :: Different attributes found?
        if not "%last_fdate%"=="%fdate%" (
            cls
            rem echo ftime=%fdate%
            :: Re-create picture
            call dot2pic "%~dpf1" "%~dpn1.jpg"
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
    echo Auto GraphViz DOT reinterpreter takes the input file name to auto render as an argument
    goto :eof
