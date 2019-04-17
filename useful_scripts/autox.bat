@echo off

:: 
:: The Batchography book by Elias Bachaalany -- http://amzn.to/1X3tQ4K
::

::
:: Auto interpret anything
::

:main
    setlocal

    set do_delay=1

    :: At least 3 arguments should be passed
    if "%3"=="" goto :help

    set do_cls=
    set do_showftime=
    set extra_args=
    set cmd_args=

    :: Take the required arguments
    set cmd_name=%~1
    shift

    set lang_name=%~1
    shift

    :: Parse the optional arguments
    :parse_args
        if "%1"=="/cls" (
            set do_cls=1
        ) else if "%1" == "/showftime" (
            set do_showftime=1
        ) else if "%1" == "/delay" (
            set /a do_delay=%~2
            shift
        ) else if "%1" == "/args" (
            set extra_args=%~2
            shift
        ) else if "%1" == "/cmdargs" (
            set cmd_args=%~2
            shift
        ) else goto :break

        shift
        goto :parse_args

    :break
        call :autox "%~1"
        goto :eof


:autox <1=FileName>
    if not exist "%~1" (
        echo Input file '%1' not found
        exit /b 1
    )

    set last_fdate=x

    title Batchography - %lang_name% auto re-interpreting '%~1' (press 'q' to quit)
    pushd "%~dp1"

    :repeat
        :: Get the file date/time (incl. seconds)
        for /f "delims=" %%i in ('"forfiles /p "%~dp1." /m "%~nx1" /c "cmd /c echo @ftime" "') do set fdate=%%i

        :: Different attributes found?
        if not "%last_fdate%"=="%fdate%" (
            if defined do_cls       cls
            if defined do_showftime echo ftime=%fdate%

            :: Re-interpret
            call "%cmd_name%" %cmd_args% "%~1" %extra_args%
        )

        :: Remember the new date/time
        set last_fdate=%fdate%

        :: Wait for a second before checking for the file modification again
        CHOICE /T %do_delay% /C "yq" /D y > nul

        :: User pressed Q? just quit
        if "%errorlevel%" neq "1" goto :eof

        :: Repeat until user quits or Ctrl-C
        goto repeat

:help
    echo Usage: autox 1=CommandName 2=LangName 3=Optional_Options FileName
    echo Optional arguments:
    echo   /cls               clear the screen before auto-interpreting
    echo   /showftime         show the file time stamp before auto-interpreting
    echo   /delay nsecs       the delay before auto-interpreting. default is %do_delay% second.
    echo   /cmdargs           optional additional arguments to be passed to the command
    echo   /args "arg1 arg2"  optional additional arguments to be passed to the filename
    goto :eof
