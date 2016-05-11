@echo off

setlocal enabledelayedexpansion

echo a^) 1=%1 2=%2 3=%3

if 1==1 (
	shift
	echo 1'=%1 2'=%2
)

shift
echo b^) 1=%1 2=%2 3=%3