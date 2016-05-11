@echo off

for /r . %%a IN (*.bat) DO (
	ECHO matched file: %%a
)
