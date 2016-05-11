@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

setlocal

set Name=Mr. Anderson

echo The %%Name%% variable will not be exported to the interpreter or calling script

endlocal

set Age=33

echo The %%Age%% variable will be exported to the parent's environment variable space.