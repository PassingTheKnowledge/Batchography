@echo off


:: 
:: The Batchography book by Elias Bachaalany
::


setlocal enabledelayedexpansion

:test-all
	for %%a in (
		test-create-with-size
		test-find
		test-delete
		test-insert
		test-love-story
	) do (
		echo --BEGIN %%a -------------------------------
		call :%%a
		echo --END %%a ---------------------------------
	)

	goto :eof

:: ==================================================================
:test-love-story
	call :array-create A1
	call :array-append A1 "elias" "peter" "mike"

	echo The values are:
	set A1[

	call :array-insert A1 1 "mary"
	echo The new values are:
	set A1[

	call :array-delete A1 2
	echo The values after deletion:
	set A1[

	call :array-find A1 "mike"
	if "%errorlevel%" equ "-1" (
		echo Mike is hiding somewhere! Oh man!
	) else (
		call :array-delete A1 %errorlevel%
		echo Mike's busted.
		echo New values are now:
		set A1[
	)

	call :array-destroy A1
	echo The values after destruction are:
	set A1[

	goto :eof

:: ==================================================================
:test-find
	call :array-create T1
	
	call :array-append T1 1 2 6 12 0 44 99 44 912 6 2 5 1
	echo The array's contents are:
	set T1[

	echo Finding items:

	set needle=12
	call :array-find T1 %needle%
	echo Found "%needle%" at %errorlevel%

	set needle=112
	call :array-find T1 %needle%
	echo Found "%needle%" at %errorlevel%

	set needle=6
	call :array-find T1 %needle%
	echo Found "%needle%" at %errorlevel%

	set /a p=%errorlevel%+1
	call :array-find T1 %needle% %p%
	echo Found next "%needle%" at %errorlevel%

	goto :eof

:: ==================================================================
:test-create-with-size
	call :array-create T1 5
	set T1

	goto :eof

:: ==================================================================
:test-delete
	call :array-create T1
	call :array-append T1 0 1 2 3
	set T1[

	echo Deleting...
	call :array-delete T1 0

	set T1[

	goto :eof

:: ==================================================================
:test-insert
	setlocal
	:: ArrayLib
	call :array-create ARR

	call :array-append ARR 10 20

	for /l %%a in (4, 1, 6) do (
		set /a t=%%a*10
		call :array-append ARR !t!
	)	

	set ARR[

	echo The array's length is: %ARR.length%

	call :array-insert ARR 2 30

	set ARR[

	call :array-insert ARR 0 0

	echo The array's length is: %ARR.length%

	call :array-destroy ARR

	set ARR[

	echo ===
	echo ===

	call :array-create T1
	call :array-append T1 0 1 3 4 5 7
	call :array-insert T1 2 2
	call :array-insert T1 6 6
	call :array-insert T1 0 -1

	set T1[

	endlocal
	goto :eof


:: ==================================================================
::
:: Create an empty array (or with the given size if specified)
::
:array-create <1=ArrayName> <2=size>
	if defined %~1.length call :array-destroy %1

	:: No size specified?
	if "%~2" equ "" (
		set %~1.length=0
	) else (
		:: Create an array with the size
		set /a array_create_len=%~2-1
		for /l %%a in (0, 1, !array_create_len!) do (
			set %~1[%%a]=0
		)
		set %~1.length=%~2
		set array_create_len=
	)

	goto :eof


:: ==================================================================
::
:: Destroy the array (and all its elements)
::
:array-destroy <1=ArrayName>
	:: Compute the length
	call set /a len=%%%~1.length%%%-1
	:: Clear array values
	for /L %%a in (0, 1, %len%) do (
		set %~1[%%a]=
	)
	:: Clear the length attribute
	set %~1.length=

	goto :eof


:: ==================================================================
::
:: Append an element into the end of the array
::
:array-append <1=ArrayName> <2=Value>
	:array-append-repeat
		call set %~1[%%%~1.length%%]=%~2
		set /A %~1.length+=1
		shift /2
		if "%~2" NEQ "" goto array-append-repeat
	goto :eof


:: ==================================================================
::
:: Insert an element at a given position into the array
::
:array-insert <1=ArrayName> <2=Position> <3=Value>
	call set array_insert_len=%%%~1.length%%
	if %~2 GEQ %array_insert_len% (
		echo Error: out of bounds!
		exit /b -1
		goto :eof
	)
	
	:: Shift items to the right
	set /a array_insert_pa=%~2+1
	for /L %%a in (%array_insert_len%, -1, %array_insert_pa%) do (
		set /a array_insert_pa=%%a-1
		call set %~1[%%a]=%%%~1[!array_insert_pa!]%%
	)

	:: Insert the new value
	set %~1[%~2]=%~3

	:: Increase the length
	set /a %~1.length+=1

	set array_insert_len=
	set array_insert_pa=

	goto :eof


:: ==================================================================
::
:: Delete an element from the array at a given position
::
:array-delete <1=ArrayName>	<2=Position>
	call set /a array_delete_len=%%%~1.length%%
	if %~2 GEQ %array_delete_len% (
		echo Error: out of bounds!
		exit /b -1
		goto :eof
	)
	
	set /a array_delete_len-=1

	:: Shift items to the left
	for /L %%a in (%~2, 1, %array_delete_len%) do (
		set /a array_delete_pa=%%a+1
		call set %~1[%%a]=%%%~1[!array_delete_pa!]%%
	)

	:: Purge the last element (since we shifted to the left)
	set %~1[%array_delete_len%]=

	:: Decrease the length
	set /a %~1.length-=1

	set array_delete_len=
	set array_delete_pa=

	goto :eof


:: ==================================================================
::
:: Find an element in the array and return the position
::
:array-find <1=ArrayName> <2=Value> <3=Start Pos> => <errorlevel=foundpos>
	:: Set a default position if not set
	set array_find_p=%~3
	if not defined array_find_p set array_find_p=0

	:: Get the length
	call set /a array_find_len=%%%~1.length%%

	:: Check the bounds of the start position
	if %array_find_p% GEQ %array_find_len% (
		echo Error: out of bounds!
		exit /b -1
		goto :eof
	)
	

	:: Search all items
	set /a array_find_len-=1
	for /L %%a in (%array_find_p%, 1, %array_find_len%) do (
		call set array_find_len=%%%~1[%%a]%%
		if "!array_find_len!" equ "%~2" (
			set array_find_len=
			set array_find_p=
			exit /b %%a
		)
	)

	set array_find_len=
	set array_find_p=
	exit /b -1


:: ==================================================================
::
:: Find an element in the array and return the position
::
:array-join <1=ArrayName> <2=Separator> => <3=Result>
	:: Left as an exercise for the readers
	goto :eof
