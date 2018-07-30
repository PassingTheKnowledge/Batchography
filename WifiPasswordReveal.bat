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

    :: Detect the language
    for /F "usebackq tokens=3" %%a IN (`reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage`) DO (
        :: 0409 English ; 0407 German ; 040C French ; 0C0A Spanish
        :: https://docs.microsoft.com/en-us/previous-versions/office/developer/speech-technologies/hh361638(v=office.14)
        set lang_id=%%a
    )

    if "%lang_id%"=="0409" (
        echo English operating system language detected
    ) else if "%lang_id%" == "040C" (
        set KEYCONTENT=Contenu de la cl
        set ALL_PROFILES=Profil Tous les utilisateurs

        echo French operating system language detected
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
