@echo off

:: 
:: The Batchography book by Elias Bachaalany
::

echo Self is: %0

:: Start modifiers example
echo 1. without quotes: %~0
echo 2. fully qualified path name: %~f0
echo 3. drive letter: %~d0
echo 4. path part: %~p0
echo 5. just the file name part: %~n0
echo 6. just the extension part: %~x0
echo 7. file's attributes: %~a0
echo 8. file's date and time: %~t0
echo 9. file's size: %~z0
echo 10. file path in the PATH environment variable search: %~$PATH:0
echo 11. file's full path: %~dp0
echo 12. file's name and extension part: %~nx0
echo 13. 'dir' like modifier: %~ftza0
echo 14. fully qualified script path: %~dpnx0