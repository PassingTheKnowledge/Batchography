@echo off
rem = """
:: 
:: The Batchography book by Elias Bachaalany
::

:: Anything batch file goes here but will be ignored by Python
python -x "%~f0" %*
exit /b %errorlevel%
:: End of batch file commands
"""

# Anything here is interpreted by Python

import platform
import sys

print("Hello world from Python %s!\n" % platform.python_version())
print("The passed arguments are: %s" % sys.argv[1:])