# Load Conda
module load anaconda/2021

# Activate environment
source activate pyarm2021 || conda activate pyarm2021

echo "===== Environment Activation ====="
which python
python --version

echo "===== Check Installed Python Packages ====="
python -c "import numpy, propka, texttable, crontab, MDAnalysis, openbabel; print('All core Python packages imported successfully.')"

echo "===== Check Binary Paths ====="
which fpocket
which propka3
which gmx
which modeller
which GromacsWrapper || echo "GromacsWrapper not in PATH (verify pip installation)."

echo "===== Test GromacsWrapper Import ====="
python -c "import GromacsWrapper; print('GromacsWrapper successfully imported.')"

echo "===== Test Completed Successfully ====="
