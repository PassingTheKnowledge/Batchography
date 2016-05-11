@echo off

SET C=-1
FOR /L %%a IN (1, 1, 4) DO (
	set C=%%a
	echo a=%%a, C=%C%
)

ECHO after the loop, C=%C%