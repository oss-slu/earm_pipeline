# pyARM HPC Setup Guide

This guide helps contributors and users set up and run pyARM on the HPC cluster (Libra).

---

## 1. Login to the HPC
```bash
ssh <your_username>@<hpc_address>
hostname   # should show login01

2. Access the Shared Project Directory

cd /projects/earm
ls
# You should see test.py and other shared files

cd /projects/earm
ls
# You should see test.py and other shared files


If /projects isn’t visible on compute nodes, contact admins to mount it.

3. Load Required Modules

module avail python
module load python/3.13.0-gcc-13.1.0-7yp12
python --version

4. Install Miniconda (if needed)

cd $HOME
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda --version


5. Create the Conda Environment
Create an environment.yml like below:

name: pyarm2021
channels:
  - conda-forge
  - salilab
  - defaults
dependencies:
  - python=3.9
  - numpy
  - propka
  - texttable
  - python-crontab
  - fpocket
  - mdanalysis
  - openbabel
  - modeller
  - pip:
      - git+https://github.com/Becksteinlab/GromacsWrapper.git


Then run:

conda env create -f environment.yml -n pyarm2021
conda activate pyarm2021


6. Configure Modeller License

nano ~/miniconda3/envs/pyarm2021/lib/modeller-10.7/modlib/modeller/config.py
# Replace license = r'XXXX' with your key


7. Verify Installation

python -c "import numpy, propka, texttable, crontab, MDAnalysis, openbabel, modeller; print('All dependencies OK!')"


8. Update pyARM Configs
Edit:
configs/arm_config.yaml
configs/a_arm_paths.py
Example paths:

tools:
  vmd: "/projects/earm/tools/vmd/bin/vmd"
  pdb2pqr: "/projects/earm/tools/pdb2pqr/pdb2pqr.py"
  dowser: "/projects/earm/tools/dowser/dowser"
  gromacs: "/cm/shared/spack_modulefiles/linux-rhel9-x86_64/Core/gromacs/2023/bin/gmx"
  molcas: "/projects/earm/tools/molcas/molcas"
  tinker: "/projects/earm/tools/tinker/bin"


9. Run Tests

bash scripts/test_env.sh
bash scripts/test_paths.sh


10. Next Steps
Verify compute node access
Run a small workflow test
Document differences for future users


