@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal enabledelayedexpansion

:: Create the array
set V[0]=5
set V[1]=10
set V[2]=15

:: Display all values
for /L %%a in (0, 1, 2) do (
	echo V[%%a]=!V[%%a]!
)

:: Delete the array
for /L %%a in (0, 1, 2) do (
	set V[%%a]=
)

:: Display the array values
set V[
