@echo off
:: Batch script to convert all .jxr files in a folder to .png using jxr_to_png.exe

:: Set the path to jxr_to_png.exe
set "JXR_TO_PNG_PATH=C:\Users\daniel\dev\jxr_to_png\jxr_to_png.exe"

:: Check if jxr_to_png.exe exists
if not exist "%JXR_TO_PNG_PATH%" (
    echo jxr_to_png.exe not found at "%JXR_TO_PNG_PATH%"
    pause
    exit /b 1
)

:: Prompt user for input directory
set /p "INPUT_DIR=Enter the path to the folder containing .jxr files: "

:: Validate input directory
if not exist "%INPUT_DIR%" (
    echo The input directory "%INPUT_DIR%" does not exist.
    pause
    exit /b 1
)

:: Prompt user for output directory
set /p "OUTPUT_DIR=Enter the path to the output folder (leave blank to use input folder): "

:: If output directory is not provided, use input directory
if "%OUTPUT_DIR%"=="" (
    set "OUTPUT_DIR=%INPUT_DIR%"
)

:: Create output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
    if errorlevel 1 (
        echo Failed to create output directory "%OUTPUT_DIR%".
        pause
        exit /b 1
    )
)

echo.
echo Starting batch conversion...
echo Input Directory: "%INPUT_DIR%"
echo Output Directory: "%OUTPUT_DIR%"
echo.

:: Initialize counters
set "SUCCESS_COUNT=0"
set "FAIL_COUNT=0"

:: Iterate over all .jxr files in the input directory
for %%F in ("%INPUT_DIR%\*.jxr") do (
    echo Converting "%%~nxF"...
    "%JXR_TO_PNG_PATH%" "%%F" "%OUTPUT_DIR%\%%~nF.png"
    if errorlevel 1 (
        echo Failed to convert "%%~nxF".
        set /a FAIL_COUNT+=1
    ) else (
        echo Successfully converted "%%~nxF" to "%%~nF.png".
        set /a SUCCESS_COUNT+=1
    )
    echo.
)

echo Batch conversion completed.
echo Successful conversions: %SUCCESS_COUNT%
echo Failed conversions: %FAIL_COUNT%
pause

