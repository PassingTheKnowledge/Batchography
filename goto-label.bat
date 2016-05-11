@echo off

goto %1

echo Unreachable code

:ValidLabel
	echo yes!
	goto :eof
