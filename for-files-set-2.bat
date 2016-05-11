@echo off

setlocal

for %%a in (
	t*.bat
	*.exe
	"my *.txt"
	Myfile.txt
	Readme.txt
) do (
	echo found: %%a
)

endlocal
