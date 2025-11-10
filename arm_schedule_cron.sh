#!/bin/bash -l

# Source bashrc for environment variables
source ~/.bashrc

# Load pyARM module
module use /projects/earm/modules
module load pyARM-2021

# Activate pyARM conda environment
source /projects/earm/local/miniconda3/conda/bin/activate /projects/earm/envs/pyarm2021

# Determine the directory where this script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Script directory: $DIR"

# Extract AARM-ROOT path from a_arm_paths.py
root00=$(grep AARM-ROOT ${DIR}/../a_arm_paths.py | grep :)
root01=${root00#*:}
root02=${root01//\'/}

# Optional debug info (uncomment if needed)
# echo "Resolved root path: ${root02}"
# echo "PATH: $PATH"
# echo "PYTHONPATH: $PYTHONPATH"
# echo "Which python: $(which python)"

# Run the pyARM crontab driver script
python ${root02}/scripts/a_arm_crontab_driver/a_arm_crontab.py
