@echo off

:: Do not expose all the environment variables used in this script
SETLOCAL

:: Simple expression

SET /A var1="1+(2*4)"

:: Referring to another variable without enclosing with the percentage character
SET /A var2=var1 + 2

:: Bitwise AND
SET /A var3="var1 & 1"

:: Modulus
SET /A var4="var1 %% 2"

:: Shift to the left
SET /A var5="1<<7"

:: Bitwise negation
SET /A var6="~var1"

:: Defining hexadecimal number
SET /A var7="0x1234"

:: Shift left assignment
SET /A var8=1
SET /A var8^<^<=2

:: Display all the variables
SET var

IF %var3% EQU 1 echo var1 is odd

ENDLOCAL