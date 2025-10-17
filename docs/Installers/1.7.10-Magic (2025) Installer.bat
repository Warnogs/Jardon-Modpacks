@echo off

echo =====================================================
echo            1.7.10 Magic (2025) Installer
echo =====================================================
echo:

REM Change directory to .minecraft in AppData
cd /d "%appdata%\.minecraft"

REM Delete existing mods folder if it exists
if exist "mods" (
    echo Deleting existing mods folder...
    rmdir /s /q "mods"
)

REM Clone the Git repository into a new mods folder
echo Cloning repository...
git clone https://github.com/Warnogs/Jardon-Modpacks.git mods

REM Change directory to mods folder
cd mods

REM Checkout the desired branch or tag
echo Checking out 1.7.10-Magic-2025...
git checkout 1.7.10-Magic-2025

echo:
echo Cleaning Up...

REM Delete the .git folder to reduce load times
if exist ".git" (
    echo Removing .git folder...
    rmdir /s /q ".git"
)

REM Delete the README.md file if it exists
if exist "README.md" (
    echo Removing README.md...
    del /f /q "README.md"
)

echo:
echo Done!
pause
