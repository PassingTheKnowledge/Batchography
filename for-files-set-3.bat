@echo off

setlocal

for %%a in (
	"command 1"
	"command 2"
	"command 3"
	"string 1"
	"string 2") DO (
	ECHO item=%%~a
)

endlocal