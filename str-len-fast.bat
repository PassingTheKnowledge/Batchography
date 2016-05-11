@echo off

:main
    setlocal
    set /P str=Enter string: 
    call :strlen "%str%"
    echo length=%errorlevel%

    call :strlen ""
    echo length of empty string=%errorlevel%

    goto :eof

:strlen <1=string> => errorlevel
    setlocal enabledelayedexpansion
    set "s=%~1."
    set len=0
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            set "s=!s:~%%P!"
        )
    )

    ( 
        endlocal
        exit /b %len%
    )