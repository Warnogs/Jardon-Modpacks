@echo off
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

echo Done.
pause
