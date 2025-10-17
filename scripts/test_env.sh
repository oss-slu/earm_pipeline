#!/bin/bash
source ~/.bashrc
conda activate pyarm2021

echo "----------------------------------------"
echo "Testing Python environment..."
echo "----------------------------------------"

python -c "import numpy, propka, texttable, MDAnalysis, openbabel; print('✅ PyARM dependencies loaded successfully!')"

echo "Environment test complete."
