@echo off

: this is a comment
:: this is a comment
REM this is a comment too

ECHO Hello &::This is a comment

ECHO Multiple line comments
GOTO after_comment
Hello
This is really free text!
The interpreter will not execute those lines

:after_comment
ECHO End of multiple line comments
