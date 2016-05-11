@echo off

if "%1"=="clean" (
	del newfile.txt
	del file2.txt
	del stderr-file.txt
	del out.txt
	del stdout-file.txt
	del out2.txt
	goto :eof
)

ECHO This will be written to a file>newfile.txt
ECHO This will be appended or written to file2.txt >>file2.txt
ECHO This will also be written to file2.txt >>file2.txt
ECHO This will overwrite newfile.txt>newfile.txt
ECHO This will redirect the stdout and stderr to two separate text files>stdout-file.txt 2>stderr-file.txt
ECHO This will redirect the stdout to a file and stderr to the same output >stdout-file.txt 2>&1
ECHO Nothing will be displayed!>NUL


>out.txt echo hello world!
type out.txt

>nul dir /w

