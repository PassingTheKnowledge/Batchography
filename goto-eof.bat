@echo off

goto eof

echo Unreachable, due to jumping to a label in the file.

:eof

echo a real label is here

goto :eof


echo Unreached code, due to "GOTO :EOF"