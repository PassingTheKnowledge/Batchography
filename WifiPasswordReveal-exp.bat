@echo off

::
:: (c) Elias Bachaalany <lallousz-x86@yahoo.com>
:: Batchography: The Art of Batch Files Programming
::

setlocal enabledelayedexpansion

:main
    title WiFiPasswordReveal v1.1 (c) lallouslab.net - The Batchography book
    
    echo.
    echo Reveal all saved WiFi passwords Batch file script v1.1 (c) lallouslab.net
    echo.
    echo Inspired by the book "Batchography: The Art of Batch Files Programming"
    echo.

    :: Default language is English
    set KEYCONTENT=Key Content
    set ALL_PROFILES=All User Profile

    ::
    :: Detect the language (1033 English ; 1036 French)
    :: See https://technet.microsoft.com/en-us/library/cc287874(v=office.12).aspx
    ::

    for /F "usebackq tokens=*" %%a IN (`wmic os get OSLanguage /Value`) DO (
        set _line=%%a
        if "!_line:~0,10!"=="OSLanguage" (
            set lang_id=!_line:~11!
        )
    )

    if "%lang_id%"=="1033" (
        echo English operating system language detected!
    ) else if "%lang_id%" == "1036" (
        set KEYCONTENT=Contenu de la cl
        set ALL_PROFILES=Profil Tous les utilisateurs

        echo French operating system language detected!
    ) else (
        echo Warning: Unknown operating system language detected! The script might not work correctly!
    )

    echo.

    :: Get all the profiles
    call :get-profiles r

    :: For each profile, try to get the password
    :main-next-profile
        for /f "tokens=1* delims=," %%a in ("%r%") do (
            call :get-profile-key "%%a" key
            if "!key!" NEQ "" (
                echo WiFi: [%%a] Password: [!key!]
            )
            set r=%%b
        )
        if "%r%" NEQ "" goto main-next-profile

    echo.
    pause

    goto :eof

::
:: Get the WiFi key of a given profile
:get-profile-key <1=profile-name> <2=out-profile-key>
    setlocal

    set result=

    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profile name^="%~1" key^=clear ^| findstr /C:"%KEYCONTENT%"`) DO (
        set result=%%a
        set result=!result:~1!
    )
    (
        endlocal
        set %2=%result%
    )

    goto :eof

::
:: Get all network profiles (comma separated) into the result result-variable
:get-profiles <1=result-variable>
    setlocal

    set result=

   
    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profiles ^| findstr /C:"%ALL_PROFILES%"`) DO (
        set val=%%a
        set val=!val:~1!

        set result=%!val!,!result!
    )
    (
        endlocal
        set %1=%result:~0,-1%
    )

    goto :eof
