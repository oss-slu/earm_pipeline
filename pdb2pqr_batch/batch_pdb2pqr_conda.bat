@echo off
REM batch_pdb2pqr_conda.bat - Convert PDB to PQR using pdb2pqr in conda env

REM Set paths
set INPUT_DIR=%~dp0input_pdbs
set OUTPUT_DIR=%~dp0output_pqr

REM Create folders
if not exist "%INPUT_DIR%" mkdir "%INPUT_DIR%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Download 1CRN.pdb if not present
if not exist "%INPUT_DIR%\sample_crn.pdb" (
    echo Downloading 1CRN.pdb...
    powershell -Command "Invoke-WebRequest -Uri 'https://files.rcsb.org/download/1CRN.pdb' -OutFile '%INPUT_DIR%\sample_crn.pdb'"
)

REM Activate conda environment
call conda activate pyarm2021
if errorlevel 1 (
    echo ERROR: Failed to activate conda environment
    exit /b 1
)

REM Convert all .pdb files
for %%f in ("%INPUT_DIR%\*.pdb") do (
    echo Converting %%~nxf...
    pdb2pqr --ff=AMBER "%%f" "%OUTPUT_DIR%\%%~nf.pqr"

    if errorlevel 1 (
        echo ERROR converting %%~nxf
    ) else (
        echo SUCCESS: %%~nxf converted
    )
)

echo Done!
pause
