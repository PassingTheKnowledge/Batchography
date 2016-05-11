@if (1 == 0) @end /*
@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

cscript.exe /E:jscript /nologo "%~f0" %*
goto :eof */
WScript.Echo("Hello world from Windows Scripting Host!");

for (var i=0, c=WScript.Arguments.length;i<c;i++)
{
	WScript.Echo("Arg:" + WScript.Arguments(i));
}
