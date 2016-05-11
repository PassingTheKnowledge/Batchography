@echo off

:Main
    setlocal enabledelayedexpansion

    if "%1"==""         goto Usage
    if "%1"=="/?"       goto Usage
    if "%1"=="/help"    goto Usage

    set ForceFlag=0
    goto ParseActions

:ParseActions
    :: Parse actions
    if /I "%1"=="adduser" set action=adduser
    if /I "%1"=="removeuser" set action=removeuser
    if /I "%1"=="removeuser" set action=removeuser
    if /I "%1"=="initscript" set action=initscript

    if "%action%"=="" goto Usage

    shift
    goto ParseOptions

:ParseOptions
    set S=
    if "%1"=="" goto Handle-%action%

    if "%1"=="/user" (
        if "%2"=="" (
        :ErrNoUserPassed
            echo No username passed!
            goto Usage
        )
        set Username=%~2
        set S=2
    )

    if "%1"=="/password" (
        if "%2"=="" (
        :ErrNoPasswordPassed
            echo No password was specified
            goto Usage
        )
        set Password=%~2
        set S=2
    )

    if "%1"=="/force" (
        set S=1
        set ForceFlag=1
    )

    if "%1"=="/script" (
        if "%2"=="" (
        :ErrNoScriptPassed
            echo No script file specified
            goto Usage
        )
        if not exist "%~2" (
            echo The script file is not found!
            goto Usage
        )
        set Script=%~2
        set S=2
    )

    if not defined S (
        echo Invalid switch!
        goto Usage
    )
    FOR /L %%a in (1, 1, %S%) DO SHIFT

    goto ParseOptions

:Handle-adduser
    if "%Username"=="" goto ErrNoUserPassed
    if "%Password%"=="" goto ErrNoPasswordPassed

    echo Adding user '%username%' with password '%Password%'
    goto :eof

:Handle-removeuser
    if "%Username"=="" goto ErrNoUserPassed

    echo Removing user: %Username%
    goto :eof

:Handle-initscript
    if "%Username"=="" goto ErrNoUserPassed
    if "%Script%"=="" goto ErrNoScriptPassed

    echo Setting user '%Username%' script @ %script%
    goto :eof

:Usage
    echo Usage:
    echo ------
    echo.
    echo %~n0 action [/option value] [/option]
    echo.
    echo To display help, run it as:
    echo.
    echo %~n0 /? ^| parse-args /help 
    echo.
    echo Actions:
    echo --------
    echo.
    echo * adduser /user username /password password
    echo.
    echo Adds a user to the system with the designated password.
    echo.
    echo * removeuser /user username [/force]
    echo.
    echo Removes a user from the system. If the /force flag is set then
    echo the current user is logged off and the account is removed.
    echo.
    echo * initscript /user username /script ^<script name^>
    echo.
    echo Sets the user's initialization script. The script file should exist,
    echo or the command may fail.
    echo.
    goto :eof
