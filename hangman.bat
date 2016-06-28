@echo off
::
:: Hangman Game
:: (c) Batchography book - by Elias Bachaalany
::
cls
setlocal enabledelayedexpansion
title Hangman game - Batchography book - by Elias Bachaalany

:: --------------------------------------------------------------------------
:start
	:: Test selector
	if not "%1"=="" (
		call :test-%1 2>nul || (
			echo Invalid test function!
			goto :eof
		)
		goto :eof
	)

	call :PlayGame
	goto :eof

:: --------------------------------------------------------------------------
:PlayGame
	:PlayGame-Again
	call :get-random-line words-sat300.txt word
	if defined GodMode echo The Word is '%word%' & pause

	call :Game %Word%
	choice /c:yn /m "Do you want to play more?"
	if "%ERRORLEVEL%" EQU "1" goto PlayGame-Again

	pause
	goto :eof
	

:: --------------------------------------------------------------------------
::
:: Game loop
:: 
:Game <1=WordToGuess>
	setlocal enabledelayedexpansion

	:: Reset the retries counter
	set /a MAX_TRIES=5
	set /a NbTries=0

	:: Initialize the word
	set Word=%~1

	:: Initialize the word bits
	call :init-word-bits "%Word%" WordBits

	:: Reveal nothing
	call :reveal-letters "%Word%" WordBits _ RevealedWord

	:Game-Letter-Loop
		cls
		call :draw-hangman %NbTries%

		:: Did we exhaust all the tries?
		if !NbTries! EQU !MAX_TRIES! (
			echo.
			echo Game over^^! The word was: '%Word%'^^!
			echo.
			exit /b 0
		)

		ECHO Guess: %RevealedWord%

		:: Did we reveal all the letters?
		if /I "!Word!"=="!RevealedWord!" goto Game-Finished

		:: Take a single letter
		SET /P Letter="Enter a letter: "
		SET Letter=!Letter:~0,1!

		set OldBits=!WordBits!
		call :reveal-letters "%Word%" WordBits !Letter! RevealedWord

		:: If nothing was revealed then decrease the number of tries
		if !OldBits!==!WordBits! SET /A NbTries+=1

		:: Repeat
		goto :Game-Letter-Loop

	:Game-Finished
	echo.
	echo Good job^^!
	echo.
	endlocal
	EXIT /b 1


:: --------------------------------------------------------------------------
::
:: Reveal letters in a word
::
:reveal-letters
:: Args: 
::  	<1=Word-Val>              The value of the word
::  	<2=WordBits-Var-InOut>    WordBit variable name
::  	<3=Letter-Val>            The letter to reveal
::  	<4=NewWord-Var-Out>       Variable to hold the revealed word
::  Returns: 
::  	Number of newly revealed letters

 	setlocal enabledelayedexpansion

	:: Get the input string length
	set Word=%~1
	call :strlen "%Word%"
	set /A WordLen=%errorlevel%-1

	:: Get the current revelation bits
	set Bits=!%~2!

	:: Reset internal variables
	set NewBits=
	set NewWord=
	set /A NbReveal=0

	:: Scan and reveal
	for /L %%i in (0, 1, %WordLen%) DO (
		
		:: Take the revealed letter
		set Word_I=!Word:~%%i,1!
		
		:: Take the current revelation bit
		set Bit_I=!Bits:~%%i,1!

		:: Not previously revealed?
		if !Bit_I! EQU 0 (
			:: Check whether to reveal
			if /I "%~3"=="!Word_I!" (
				set Bit_I=1
				set /A NbReveal += 1
			) ELSE (
				set Word_I=_
			)
		)
		:: Form new revelation bits and word
		set NewBits=!NewBits!!Bit_I!
		set NewWord=!NewWord!!Word_I!
	)
	(
		endlocal
		set %~4=%NewWord%
		set %~2=%NewBits%

		exit /b %NbReveal%
	)
	

:: --------------------------------------------------------------------------
::
:: Initialize the word bits. Create the corresponding empty bits
::
:init-word-bits <1=word> <2=wordbits-var>
	setlocal enabledelayedexpansion
	set Word=%~1
	set WordBits=

	call :strlen "%Word%"
	set /a len=%errorlevel%-1
	for /L %%i in (0, 1, %len%) DO (
		set Word_I=!Word:~%%i,1!
		if "!Word_I!"==" " (set Bit_I=1) else (set Bit_I=0)
		set WordBits=!WordBits!!Bit_I!
	)
	(
		endlocal
		set %~2=%WordBits%
		exit /b 0
	)


:: --------------------------------------------------------------------------
::
:: Draw the hangman in progression
:: 
:draw-hangman <1=steps>

	if "%~1" EQU "0" (
		echo.
		echo.
		echo.
		echo.
		echo.
	)

	if "%~1" EQU "1" (
		echo      (o.o^)
		echo.
		echo.
		echo.
		echo.
	)

	if "%~1" EQU "2" (
		echo      (o.o^)
		echo.       ^|
		echo.    ___^| 
		echo.
		echo.
	)

	if "%~1" EQU "3" (
		echo      (o.o^)
		echo.       ^|
		echo.    ___^|___
		echo.
		echo.
	)

	if "%~1" EQU "4" (
		echo      (o.o^)
		echo.       ^|
		echo.    ___^|___
		echo.       ^|
		echo.      /
	)

	if "%~1" EQU "5" (
		echo      (o.o^)
		echo.       ^|
		echo.    ___^|___
		echo.       ^|
		echo.      / \
	)

	exit /b 0

:: --------------------------------------------------------------------------
::
:: Get random line
:: 
:get-random-line <1=filename> <2=result-var>
	setlocal enabledelayedexpansion
	set MAXLINES=-1
	for /f "useback tokens=1 delims=:" %%a in (`findstr /N /B /C:"#" "%~1"`) DO set MAXLINES=%%a

	if %MAXLINES% EQU -1 (
		echo Fatal error: the words list file %1 does not end with the "#" marker!
		call :TermScript 2>nul
	)

	:: Get the random line number. Draw the random line a few times to increase randomness.
	set /a i=0
	:get-random-line-rnd
		SET /A RANDLINE="(%RANDOM% %% (MAXLINES-1))"
		set /a i+=1
		if %i% NEQ 3 goto get-random-line-rnd
	
	if %RANDLINE% EQU 0 (SET SKIPSTX=) ELSE (SET SKIPSTX=skip=%RANDLINE%)

	:: Skip some lines and return a single line (word)
	for /f "usebackq %SKIPSTX% delims=" %%w in ("%~1") DO (
		endlocal
		set %~2=%%w
		exit /b 0
	)


:: --------------------------------------------------------------------------
::
:: Compute string length
::
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
    :: Return the length
    ( 
        endlocal
        exit /b %len%
    )

:: --------------------------------------------------------------------------
:: Terminate the script using a syntax error
:: 
:TermScript
if


:: --------------------------------------------------------------------------
:: All tests

::
:: Test the game
::
:test-Game
	call :Game "More light"
	EXIT /B 0
	
::
:: Test the init word bits function
::
:test-init-word-bits
	call :init-word-bits "123" v
	echo bits=%v%

	exit /b 0

::
:: Test letter revelation functions
::
:test-reveal-letters
	setlocal
	set word=hello elias
	echo The word is: '%word%'
	call :init-word-bits "%word%" bits
	echo InitBits=%bits%

	call :reveal-letters "%word%" bits _ rev
	echo Reveal nothing = %rev%

	call :reveal-letters "%word%" bits l rev
	echo Reveal 'l' = %rev%

	call :reveal-letters "%word%" bits e rev
	echo Reveal 'e' = %rev%

	call :reveal-letters "%word%" bits h rev
	echo Reveal 'h' = %rev%

	endlocal
	exit /b 0


::
:: Test the draw hangman function
::
:test-draw-hangman

	for /l %%i in (1,1, 5) DO (
		echo =========== step %%i ================
		call :draw-hangman %%i
	)
	goto :eof

::
:: Test the get random line
:: 
:test-get-random-line
	call :get-random-line words-sat300.txt w
	echo word=%w%
	exit /b 0
