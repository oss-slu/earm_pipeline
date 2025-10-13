#!/bin/bash
# pyARM HPC Installation Script – Sprint 3
echo "=== pyARM HPC Setup Starting ==="
# 1. Load Python
module load python/3.13.0-gcc-13.1.0-7yp12 || true
# 2. Install Miniconda if needed
if ! command -v conda &> /dev/null; then
    echo "Installing Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/Miniconda3.sh
    bash ~/Miniconda3.sh -b -p $HOME/miniconda3
    source ~/miniconda3/bin/activate
fi
# 3. Create environment
if [ ! -d "$HOME/miniconda3/envs/pyarm2021" ]; then
    conda env create -f env/environment_hpc.yml -n pyarm2021
fi
source ~/.bashrc
conda activate pyarm2021
# 4. Verify dependencies
python -c "import numpy, propka, texttable, MDAnalysis, openbabel; print('All Python packages OK')"
# 5. Set up configs
mkdir -p ~/earm_pipeline/configs
cp configs/arm_config.yaml configs/a_arm_paths.py ~/earm_pipeline/configs/
echo "=== pyARM HPC Setup Complete ==="
