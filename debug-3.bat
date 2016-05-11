@if NOT DEFINED _ECHOON (echo off)

echo Hello from this script
for /l %%a in (1, 1, 3) do (
	echo i=%%a
)