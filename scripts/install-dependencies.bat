@ECHO OFF

ECHO Checking Python...
python -V >nul 2>&1
IF %ERRORLEVEL% == 9009 (
    GOTO PYTHON_NOT_INSTALLED
)
ECHO Python found!
ECHO.

ECHO Installing PIP
python get-pip.py
ECHO.

ECHO Installing Pillow
python -m pip install pillow
python -m pip install pillow --upgrade
ECHO.

ECHO Installing PyYAML
python -m pip install pyyaml
python -m pip install pyyaml --upgrade
ECHO.

ECHO Installing Colorama
python -m pip install colorama
python -m pip install colorama --upgrade
ECHO.

ECHO Success!
ECHO.

PAUSE
EXIT

:PYTHON_NOT_INSTALLED
    ECHO Python is not installed. Please download Python 3.3 from https://www.python.org/downloads/
    ECHO.
    PAUSE