@echo off
:: 
:: The Batchography book by Elias Bachaalany
::

set /P phrase=Enter string: 
set /P match=Find what: 
set /P replace=Replace with what: 

echo The phrase is: %phrase%
call set phrase=%%phrase:%match%=%replace%%%
echo After substitution, the phrase is: %phrase%