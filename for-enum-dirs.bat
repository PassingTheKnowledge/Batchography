@echo off

FOR /D %%f IN (
		item1 
		item2 
	*.*
) DO (
	ECHO %%f
)