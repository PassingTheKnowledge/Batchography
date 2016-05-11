@echo off

setlocal enabledelayedexpansion

@if NOT DEFINED _CNDECHO (set _CNDECHO=^>NUL)

:main
    setlocal
    set /P str=Enter string: 
    echo DBG: the string value is %str% %_CNDECHO%
    call :strlen "%str%"
    echo length=%errorlevel%

    goto :eof

:strlen <1=string> => errorlevel
    set "s=%~1."
    echo DBG: inside str-len, initial value is ^<%s%^> %_CNDECHO%
    set len=0
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    	echo DBG: P=%%P str part is ^<!s:~%%P,1!^> %_CNDECHO%

        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            echo DBG: string length so far: !len! %_CNDECHO%
            set "s=!s:~%%P!"
            echo DBG: truncated string so far is: !s! %_CNDECHO%
        )
    )

    ( 
        endlocal
        exit /b %len%
    )