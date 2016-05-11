REM Single line compound commands
(dir /w & echo Some output & echo Some more output) >out.txt

REM Multiple lines compound commands
(
	dir /w
	echo Some output 
	echo Some more output
) >out2.txt