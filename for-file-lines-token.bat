@echo off

setlocal

echo Token #2 from each line:
echo ------------------------
for /F "tokens=2" %%a IN (text-tokens-1.txt) DO (
	echo %%a
)


echo Token #3 to Token #5 from each line:
echo ------------------------------------

for /F "tokens=3-5" %%a IN (text-tokens-1.txt) DO (
	echo %%a %%b %%c
)


echo Token #2 and onwards:
echo ---------------------

for /F "tokens=2*" %%a IN (text-tokens-1.txt) DO (
	echo %%a %%b
)

echo Token #6, #5 and #1 to #3:
echo --------------------------

for /F "tokens=6,5,1-3" %%a IN (text-tokens-1.txt) DO (
	echo %%a %%b %%c %%d %%e
)

endlocal