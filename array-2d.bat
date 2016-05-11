@echo off

setlocal

set TABLE[0][0]=Elias
set TABLE[0][1]=Ashmole
set TABLE[1][0]=John
set TABLE[1][1]=Smith
set TABLE[2][0]=Mary
set TABLE[2][1]=Jane


echo The names we have in the table are:
echo -----------------------------------
for /L %%a IN (0, 1, 2) do (
	echo [%%a] FirstName: '!TABLE[%%a][0]!' LastName: '!TABLE[%%a][1]!'	
)