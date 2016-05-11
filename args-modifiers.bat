@echo off

echo The first argument as is: %1

:: Start modifiers example
echo 1. without quotes: %~1
echo 2. fully qualified path name: %~f1
echo 3. drive letter: %~d1
echo 4. path part: %~p1
echo 5. just the file name part: %~n1
echo 6. just the extension part: %~x1
echo 7. file's attributes: %~a1
echo 8. file's date and time: %~t1
echo 9. file's size: %~z1
echo 10. file path in the PATH environment variable search: %~$PATH:1
echo 11. file's full path: %~dp1
echo 12. file's name and extension part: %~nx1
echo 13. 'dir' like modifier: %~ftza1
echo 14. fully qualified script path: %~dpnx0