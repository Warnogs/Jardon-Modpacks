@echo off
echo =====================================================
echo            1.7.10 Magic (2025) Installer
echo =====================================================
echo:

:: Prompt for install directory
set "installDir="
set /p "installDir=Enter the install location (example: C:\Users\User Name\AppData\Roaming\.minecraft): "

:: Remove any surrounding quotes if the user added them
set "installDir=%installDir:"=%"

:: Check if the user entered something
if "%installDir%"=="" (
    echo No directory entered. Installation aborted.
    pause
    exit /b
)

:: Check if directory exists, if not ask to create it
if not exist "%installDir%" (
    echo The directory "%installDir%" does not exist.
    set /p "createDir=Would you like to create it? (Y/N): "
    if /i "%createDir%"=="Y" (
        mkdir "%installDir%"
    ) else (
        echo Installation aborted.
        pause
        exit /b
    )
)

echo:
echo Installing to: "%installDir%"
echo:

:: Change directory to chosen install directory
pushd "%installDir%" || (
    echo Failed to change directory to "%installDir%".
    pause
    exit /b
)

:: Delete existing mods folder if it exists
if exist "mods" (
    echo Deleting existing mods folder...
    rmdir /s /q "mods"
)
echo:

:: Clone the Git repository into a new mods folder
git clone https://github.com/Warnogs/Jardon-Modpacks.git mods
echo:

:: Change directory to mods folder
pushd "mods" || (
    echo Failed to change directory to mods folder.
    pause
    exit /b
)

:: Checkout the desired branch or tag
echo Checking out 1.7.10-Magic-2025...
git checkout 1.7.10-Magic-2025

echo:
echo Cleaning Up...

:: Delete the .git folder to reduce load times
if exist ".git" (
    echo Removing .git folder...
    rmdir /s /q ".git"
)

:: Delete the README.md file if it exists
if exist "README.md" (
    echo Removing README.md...
    del /f /q "README.md"
)

popd
popd

echo:
echo Done!
pause
