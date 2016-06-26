@echo off

:: --------------------------------------------------------------------------
::
:: Change MAC Address using Batch Files
::
:: (c) Elias Bachaalany <lallousz-x86@yahoo.com>
:: Authored with the help of the following book:
::       Batchography: The Art of Batch Files Programming
::
:main
    setlocal enabledelayedexpansion

    title ChangeMACAddressBatch v1.0 (c) lallouslab.net - The Batchography book

   	:: Show help screen
	if "%1"=="help" (
		goto show-help
	)

	:: Get all relevant information
	call :get-interfaces-info iset iinfo ireg

	:: List adapters
	if "%1"=="list" (
		call :cmdline-list-adapters iset iinfo
		goto :eof
	)

	:: From here and on, operations require administrative privileges
	call :check-privilege-and-instruct
	if %errorlevel%==0 (
		pause
		goto :eof
	)

	:: If no arguments are passed, then start the interactive menu
	if "%1"=="" (
		call :check-privilege-and-abort
		call :main-menu iset iinfo
		pause
		goto :eof
	)

	:: Change adapter MAC address
	if "%1"=="change" (
		call :cmdline-change-mac-address iinfo "%~2"  "%~3"
		goto :eof
	)

	if "%1"=="reset" (
		call :cmdline-reset-mac-address iinfo "%~2"
		goto :eof
	)

	:: Internal invocation (deep and private function testing)
	if "%1"=="__internal" (
		goto internal-dispatch
	)
	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to reset an adapter's MAC address
::
:cmdline-reset-mac-address <1=iinfo> <2=adapater> <3=new mac>
	echo Resetting "%~2"'s MAC address to factory settings
	call :reset-mac-address "%~1" "%~2"

	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to change an adapter's MAC address
::
:cmdline-change-mac-address <1=iinfo> <2=adapater> <3=new mac>
	set __t=%~3
	set __t=%__t:-=%
	echo Changing "%~2"'s MAC address to "%~3"
	call :change-mac-address "%~1" "%~2" "%__t%"

	goto :eof


:: --------------------------------------------------------------------------
::
:: Command line handler to list all detected adapters
::
:cmdline-list-adapters <1=iset> <2=iinfo>
	setlocal
	if not defined DEVMODE (
		echo.
		echo Adapters friendly names list:
		echo -------------------------------
	)

	:: For each interface, return the physical address and the adapter name
	for /f "tokens=2 delims=.=" %%a in ('set %~1.') do (
		set __mac=!%~2[%%a].mac!
		set __wireless=!%~2[%%a].wireless!
		set __state=!%~2[%%a].state!

		if defined DEVMODE (
			echo !__mac!^|!__wireless!^|!__state!^|%%a
		) else (
			echo MAC Address: [!__mac!] ^| Adapter name: %%a
		)
	)
	endlocal
	goto :eof

:: --------------------------------------------------------------------------
::
:: Check for admin privilege then display instructions if needed
::
:check-privilege-and-instruct
	net session >nul 2>&1
	if %errorlevel% equ 0 exit /b 1

	call :show-banner
	echo.
	echo The %~nx0 script requires administrative privileges to run:
	echo.
	echo 1. If you are starting it from the Windows Explorer, then Right-click
	echo    on the %~nx0 script and choose "Run as administrator"
	echo.
	echo 2. If you are running it from the command prompt, then make sure you
	echo    start a new elevated command prompt and try again.
	echo.
	echo On Windows 8 and above, to start an elevated command prompt press the Win+X key 
	echo and then choose "Command Prompt (Admin)".
	echo.
	echo.
	exit /b 0

:: --------------------------------------------------------------------------
::
:: Show banner
::
:show-banner
	echo   -----================================================================================------
    echo.
    echo      Change the MAC address of network adapters - Batch file script v1.0
    echo.                     Copyright (c) by Elias Bachaalany - lallouslab.net
    echo.
    echo           Inspired by the book "Batchography: The Art of Batch Files Programming"
    echo.
	echo   -----================================================================================------
	echo.
    exit /b


:: --------------------------------------------------------------------------
::
:: Help
::
:show-help
	call :show-banner
	echo Usage:
	echo ---------
	echo.
	echo %~n0 list 
	echo  -- Lists all adapters
	echo.
	echo %~n0 change "Adapter Name" "New MacAddress"
	echo  -- Changes an adapter's MAC address
	echo.
	echo %~n0 reset "Adapter Name" 
	echo  -- Resets an adapater's MAC address
	echo.
	echo.
	exit /b


:: --------------------------------------------------------------------------
::
:: Main interactive menu
::
:main-menu <1=iset> <2=iinfo>
	:main-menu-repeat
	cls
	call :show-banner
	echo.
	echo Please choose adapter:
	echo ------------------------

	set __choices=Q
	for /f "tokens=2 delims=.=" %%a in ('set %~1.') do (
		call set __num=%%%~2[%%a].index%%
		set __choices=!__choices!!__num!
		set __c2i[!__num!]=%%a
		echo !__num!^) %%a
	)
	echo.
	echo Q^) Quit
	
	set /p=">" <nul
	choice /C:%__choices% >nul
	set /a __num=%errorlevel%-1
	if %__num%==0 (
		exit /b 0
	)

	set adapter=!__c2i[%__num%]!
	call :adapter-menu "%~2" "%adapter%"

	goto main-menu-repeat


:: --------------------------------------------------------------------------
::
:: Adapter menu
::
:adapter-menu <1=iinfo> <2=adapter>
	cls

	call set __CurMac=%%%~1[%~2].mac%%
	call :show-banner
	echo Adapter information:
	echo ---------------------
	     echo Friendly Name     :  %~2
	call echo Adapter Name      :  %%%~1[%~2].adapter%%
	     echo MAC Address       :  %__CurMac%
	call echo Connection status :  %%%~1[%~2].state%%
	echo.
	echo Please choose action:
	echo   ^(C^) Change MAC Address
	echo   ^(R^) Reset MAC address
	echo   ^(B^) Back to main menu

	set /p=">" <nul
	choice /C:"BCR" >nul
	set __option=%errorlevel%

	:: Go back to main menu
	if %__option%==1 (
		exit /b 0
	)

	:: Change MAC address
	if %__option%==2 (
		:: Prompt and validate a new MAC address
		call :prompt-new-mac-address !__CurMac! __NewMac

		:: User cancelled?
		if !errorlevel!==0 (
			goto :eof
		)
		:: Now change the MAC address
		echo Changing MAC address to !__NewMac!
		call :change-mac-address iinfo "%~2" !__NewMac!

		set /p="Adapater MAC address changed. Press any key to go back to the main menu..."<nul
		pause >nul
	)

	:: Reset MAC address
	if %__option%==3 (
		echo.
		choice /C:YN /M "Are you sure you want to reset the MAC address to its default/original value"
		:: User canceled
		if !errorlevel!==2 (
			goto :eof
		)
		:: Reset the MAC address
		echo Resetting MAC address...
		call :reset-mac-address iinfo "%~2"
		pause
	)
	goto :eof


:: --------------------------------------------------------------------------
::
:: Prompt and validate for a new MAC address
::
:prompt-new-mac-address <1=curmac> <2=newmac> => errorlevel(0=cancel, 1=ok)
	echo.
	echo.
	echo The standard (IEEE 802) format for printing MAC-48 addresses in human-friendly form is six groups of 
	echo two hexadecimal digits, separated by hyphens (-).
	echo.
	echo Very Important
	echo ---------------
	echo Note: If you are changing the MAC address of a Wireless adapater then make sure the first two hexadecimal
	echo       digits are "02" or "06", otherwise the adapter MAC address changes won't take effect.
	echo.
	echo Example MAC addresses formats include:
	echo     02-1A-11-2C-24-9D ^<-- Starts with "02" for a Wireless adapater
	echo     50-8A-CB-86-CA-AA
	echo     06-24-65-1D-C3-A2 ^<-- Starts with "06" for a Wireless adapater
	echo     00-0C-07-FC-94-08
	echo     1C-FC-BB-DB-6C-67
	echo.
	echo.	
	:prompt-new-mac-address-repeat
		echo Old MAC address: %~1
		set /p __NewMAC="New MAC address: "

		echo.
		choice /C:YN /M "Are you sure you want to change the MAC address "
		if %errorlevel%==2 (
			exit /b 0
		)
		:: Replace hyphenes
		set __NewMAC=%__NewMAC:-=%

		:: Check the proper length (too short)
		if ".%__NewMAC:~11,1%" EQU "." (
			echo.
			echo *** MAC address value too short ***
			echo.
			:: Repeat the prompt
			goto prompt-new-mac-address-repeat
		)
		:: Too long
		if ".%__NewMAC:~12,1%" NEQ "." (
			echo.
			echo *** MAC address value too long ***
			echo.
			goto prompt-new-mac-address-repeat
		)

	:: Update caller's value
	set %~2=%__NewMAC%

	:: Check if the value has changed or not
	set __t=%~1
	set __t=%__t:-=%
	if "%__NewMAC%"=="%__t%" (
		exit /b 0
	)

	:: Return success
	exit /b 1


:: --------------------------------------------------------------------------
::
::Reset MAC address for a given adapter
:: 
:reset-mac-address <1=iinfo> <2=adapter>
	set __t=!%~1[%~2].reg!
	reg delete "%__t%" /F /V NetworkAddress >nul 2>&1

	:: Refresh the interface
	call :refresh-interface "%~1" "%~2"
	goto :eof


:: --------------------------------------------------------------------------
::
:: Change MAC address
::
:change-mac-address <1=iinfo> <2=adapter> <3=NewMac>
	set __t=!%~1[%~2].reg!
	reg add "%__t%" /F /V NetworkAddress /T REG_SZ /D %~3 >nul 2>&1

	:: Refresh the interface
	call :refresh-interface "%~1" "%~2"
	goto :eof


:: --------------------------------------------------------------------------
::
:: Re=enables interface by bringing it down then up again
::
:refresh-interface <1=iinfo> <2=adapter>
	:: Bring the interface down
	netsh interface set interface "%~2" disable
	:: Bring it up again
	netsh interface set interface "%~2" enable

	:: Refresh the internal information
	call set __t=%%%~1.name%%
	call :get-interfaces-info "%__t%" "%~1" ireg

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get all relevant (combined) interfaces information
::
:get-interfaces-info <1=set-name> <2=iinfo> <3=ireg>
	:: Cache the set-name
	set %~2.name=%~1

	:: Get ipconfig information
	call :get-interfaces-ipconfig-info "%~2" "%~1"

	:: Get the interface registry key information
	call :get-interfaces-reg-keys "%~3"

	set /a __num=1
	:: Link the interface registry key information with the interface info
	for /f "tokens=2 delims=.=" %%a in ('set iset.') do (
		:: Get adapter name
		set __t=!iinfo[%%a].adapter!
		:: Get the ireg key name
		set __v=%~3[!__t!]
		:: Get the ireg key value
		call set __t=%%!__v!%%

		:: Patch-in the registry path into the iinfo
		set %~2[%%a].reg=!__t!

		:: Set a one-based index
		set %~2[%%a].index=!__num!
		set /a __num+=1
	)

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get interfaces registry key pathes into an associative array
:: Scan for both "DriverDesc" and "adapterModel" (in the case of WiFi drivers)
::
:get-interfaces-reg-keys <1=arr>
	call :get-interfaces-reg-keys-ex "%~1" "DriverDesc" 6 "Driver"
	call :get-interfaces-reg-keys-ex "%~1" "AdapterModel" 7 "Adapter"
	goto :eof


::
:: Get interfaces registry key pathes into an associative array
:: (the a-array's key is the driver description (aka the adapter name))
::
:get-interfaces-reg-keys-ex <1=arr> <2=KeyName> <3=MatchLen> <4=MatchVal>
	for /f "tokens=*" %%a in (
		'reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" /v "%~2" /s 2^>nul'
		) do (
		set __t=%%a
		if "!__t:~0,10!"=="HKEY_LOCAL" (
			set __regkey=%%a
		)
		if "!__t:~0,%3!"=="%~4" (
			for /f "tokens=2*" %%b in ("%%a") do (
				set %~1[%%c]=!__regkey!
			)
		)
	)
	set __regkey=
	set __t=

	goto :eof


:: --------------------------------------------------------------------------
::
:: Get interfaces information from the ipconfig output
::
:get-interfaces-ipconfig-info <1=arr> <2=interfaces-set>
	:: Return interface friendly names
	call :get-interfaces-netsh-info %~1

	:: For each interface, return the physical address and the adapter name
	for /f "tokens=1,2 delims=][" %%a in ('set %~1[') do (
		call :get-interface-info %~1 "%%b"
		set %~2.%%b=1
	)

	exit /b 0


:: --------------------------------------------------------------------------
::
:: Get interface information (adapter name and physical address)
::
:get-interface-info <1=arr> <2=name>
	set /a __stage=0
	for /f "tokens=*" %%a in ('ipconfig /all') do (
		set __var=%%a
		if !__stage! equ 0 (
			set __t=!__var:*adapter %~2:=!
			if "!__t!" NEQ "!__var!" (
				set /a __stage=1
				if "!__var:~0,8!"=="Wireless" (
					set __t=1
				) else (
					set __t=0
				)
				set %~1[%~2].wireless=!__t!
			)
		)
		if !__stage! EQU 1 (
			set __t=!__var:Description . . . . . . . . . . . : =!
			if "!__t!" NEQ "!__var!" (
				set %~1[%~2].adapter=!__t!
				set /a __stage+=1
			)
		)
		if !__stage! EQU 2 (
			set __t=!__var:Physical Address. . . . . . . . . : =!
			if "!__t!" NEQ "!__var!" (
				set %~1[%~2].mac=!__t!
				set /a __stage+=1
			)
		)
	)
	:: Clear work variables
	set __stage=
	set __var=
	set __t=

	goto :eof


:: --------------------------------------------------------------------------
::
:: Return the interfaces information from the netsh command
::
:get-interfaces-netsh-info <1=arr>
	FOR /F "tokens=2,3*" %%a in ('netsh interface show interface') do (
		if /i "%%a" neq "State" (
			set %1[%%c].state=%%a
		)
	)
	exit /b 0


:: --------------------------------------------------------------------------
:: Internal dispatching (test) method
:internal-dispatch
	:: Get rid of the internal argument
	shift
	:: Get the target label
	set __t=%1
	:: Go to the first argument
	shift
	goto %__t%

:: --------------------------------------------------------------------------
:tests
	call :test-get-interfaces-ipconfig-info
	call :test-get-interfaces-reg-keys
	call :test-get-interfaces-info

	goto :eof


:: Test the new MAC address prompt
:test-prompt-new-mac-address
	call :prompt-new-mac-address 11-22-33-44-55-66 newmac
	echo Result: %errorlevel% ; newmac = %newmac%
	goto :eof

::
:: Test all interfaces information
::
:test-get-interfaces-info
	call :get-interfaces-info iset iinfo ireg

	echo ----------------------------
	echo All interfactes information:
	echo ----------------------------

	set iinfo[
	goto :eof

:test-get-interfaces-reg-keys

	call :get-interfaces-reg-keys ireg
	echo Interfaces registry keys map:
	echo -----------------------------
	set ireg[
	goto :eof


:test-get-interfaces-ipconfig-info
	call :get-interfaces-ipconfig-info iinfo ifaces
	echo Interfaces information:
	echo -----------------------
	set iinfo[

	echo.
	echo All interfaces:
	echo ---------------
	set ifaces.

	goto :eof