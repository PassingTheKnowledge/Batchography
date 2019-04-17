@echo off

:: 
:: The Batchography book by Elias Bachaalany -- http://amzn.to/1X3tQ4K
::

::
:: Use SysInternal's 'strings.exe' tool to extract strings from executable files
::

if exist strs.txt del strs.txt

for %%a in (*.dll *.exe *.ocx *.sys) do (
	echo --- begin strings: %%~fa --- >>strs.txt
	"%tools%sysinternals\strings.exe" "%%~fa" >>strs.txt
	echo --- end strings: %%~fa --- >>strs.txt
)
