@echo off


:: 
:: The Batchography book by Elias Bachaalany
::


net session >nul 2>&1

if %errorlevel% neq 0 (
	echo Requires administrative privilege.
	goto :eof
)

echo Script starts here...