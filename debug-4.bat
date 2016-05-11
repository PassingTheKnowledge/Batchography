@echo off
setlocal

@if NOT DEFINED _CNDECHO (set _CNDECHO=^>NUL)

echo Hello world
for /l %%a in (1,1,3) do (
	echo this is a debug line #%%a %_CNDECHO%
	echo i=%%a
)
echo Script terminating

