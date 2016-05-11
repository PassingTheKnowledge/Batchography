@echo off

echo line 1 from main script
echo will execute second script without a CALL

use-script1.bat

echo After using the second script. This line should not execute!
