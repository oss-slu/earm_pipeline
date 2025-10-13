#!/bin/bash
source ~/.bashrc
conda activate pyarm2021
echo "Validating pyARM installation..."
python -c "import numpy, propka, texttable, MDAnalysis, openbabel; print('Python deps OK')"
which gmx || echo "GROMACS not found"
echo "Configs located in ~/earm_pipeline/configs/"
echo "Validation complete."
