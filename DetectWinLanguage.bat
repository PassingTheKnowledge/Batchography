@echo off

setlocal

:: https://docs.microsoft.com/en-us/previous-versions/office/developer/speech-technologies/hh361638(v=office.14)
:: 0409 English ; 0407 German ; 040C French ; 0C0A Spanish

for /F "usebackq tokens=3" %%a IN (`reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage`) DO (
	set lang_id=%%a
)

if "%lang_id%"=="0409" (
	echo English detected
) else if "%lang_id%" == "040C" (
	echo French detected
) else (
	echo Note: Unknown language ID %lang_id%!
)

echo LangID=%lang_id%