@echo off
:: 
:: (c) The Batchography book by Elias Bachaalany
::

	setlocal enabledelayedexpansion
	echo Extracting all embedded files...
	call :extract-all-files

	goto :eof


:extract-one-by-one

	call :extract-embedded-file "Configuration-XML" f1.xml
	echo Return value: %errorlevel%

	call :extract-embedded-file "Readme" f2.xml
	echo Return value: %errorlevel%

	goto :eof


:extract-all-files
	setlocal
	for %%a in (
		"Configuration-XML=Config.xml" 
		"Readme=README.txt"
        ) do (
			for /f "usebackq tokens=1-2 delims==" %%b in ('%%~a') do (
	        	set MSG=Extracting '%%b' to '%%c'...
	        	call :extract-embedded-file %%b %%c
	        	if %errorlevel% EQU 0 (
	        		set MSG=!MSG!done.
        		) else (
        			set MSG=!MSG!failed.
        		)
        		echo !MSG!
			)
		)

    endlocal
	goto :eof


:extract-embedded-file <1=SectionName> <2=OutFile>
	setlocal

	call :get-line-no "//<Begin-%~1" "%~f0"
	set MBEGIN=%errorlevel%

	call :get-line-no "//>End-%~1" "%~f0"
	set MEND=%errorlevel%

	:: By default, we assume failure
	set err=1
	
	if "%MBEGIN%"=="-1" goto :extract-embedded-file-end
	if "%MEND%"=="-1"   goto :extract-embedded-file-end

	:: Delete previous output file
	if exist "%~2" del "%~2"

	set /A C=MEND-MBEGIN-1

	for /f "useback skip=%MBEGIN% tokens=* delims=" %%a in ("%~f0") DO (
		echo %%a >>"%~2"
		SET /A C-=1
		if !C!==0 (
			:: Success
			set err=0
			goto :extract-embedded-file-end
		)
	)

	:extract-embedded-file-end
	(
		endlocal
		exit /b %err%
	)


:get-line-no <1=string> <2=file>
	for /f "useback tokens=1 delims=: " %%a in (`findstr /N /C:"%~1" "%~2"`) DO EXIT /B %%a
	EXIT /B -1
	goto :eof


//<Begin-Configuration-XML
<Provider>
    <Name>Microsoft-Windows-DesktopWindowManager-Diag</Name>
    <Metadata>
        <Guid>{31F60101-3703-48EA-8143-451F8DE779D2}</Guid>
        <ResourceFilePath>C:\windows\system32\dwmcore.dll</ResourceFilePath>
        <MessageFilePath>C:\windows\system32\dwmcore.dll</MessageFilePath>
        <PublisherMessage>Microsoft-Windows-DesktopWindowManager-Diag</PublisherMessage>
    </Metadata> 
    <EventMetadata>
        <Event>
            <Id>1</Id>
            <Channel>Microsoft-Windows-DesktopWindowManager-Diag/Diagnostic</Channel>
            <Level>Information</Level>
            <Task>DesktopWindowManager_DiagStats</Task>
            <Keyword>DesktopWindowManager-WDI</Keyword>
        </Event>
    </EventMetadata>
</Provider>
//>End-Configuration-XML

//<Begin-Readme
This README file contains various information about this utility.
Please refer to the online manual for more details.
//>End-Readme

echo You can write more Batch file commands in here.