# HPC-Enabled eARM Pipeline for High-Throughput Photoreceptor Mutant Discovery

This project sets up the **a-ARM / pyARM pipeline**, a computational framework for high-throughput screening of rhodopsin-like photoreceptor mutants with altered fluorescent and spectral properties. The pipeline integrates molecular modeling, structural analysis, and QM/MM methods to accelerate discovery of engineered photopigments. It automates workflows that would otherwise be slow and labor-intensive in the lab.

---

## Requirements

- Python 3.9 via Miniconda (or Anaconda)  
- VMD  
- Orient  
- GROMACS 4.5.7  
- pdb2pqr 2.1.1 (from provided source, not pip/conda)  
- Dowser (source code provided by project team)  
- Molcas (external license/software)  
- Modules system (to manage environment variables in HPC clusters)  

---

## Installation Summary & Current Status

### Step 1: Python Environment
- ✅ Shared Conda environment (`pyarm2021`) created under `/projects/earm/envs/pyarm2021`  
- ✅ Python packages installed:  
  - pip: `numpy`, `propka`, `python-crontab`, `texttable`  
  - conda: `fpocket`, `mdanalysis`, `openbabel`, `GromacsWrapper`, `modeller`  
- ✅ Modeller configured with license  
- ✅ GromacsWrapper configured for GROMACS  

### Step 2: VMD and Orient
- ✅ VMD installed (GUI + CLI)  
- ✅ Orient installed  

### Step 3: GROMACS 4.5.7
- ✅ Built from source using GCC  
- ✅ Binaries added to PATH  
- ✅ Installation verified with `mdrun`, `grompp`, `pdb2gmx`  

### Step 4: pdb2pqr 2.1.1
- ⏳ Pending installation and configuration from source  

### Step 5: Dowser
- ⏳ Pending installation and configuration  
  - Requires source code and manual bug fix  
  - Requires atomdict.db replacement  
  - Requires compilation using available Fortran compiler  

### Step 6: pyARM
- ⏳ Pending installation and integration  
  - Clone repository into `/projects/earm/software`  
  - Compile `put_ion` (Fortran)  
  - Configure `arm_config.yaml` and `a_arm_paths.py` with absolute paths for all tools (VMD, pdb2pqr, Modeller, fpocket, Dowser, Molcas, GROMACS)  
  - Configure module files (`pyARM-2021`, `gromacs`, `miniconda`, `molcas`)  
  - Install pyARM (`python setup.py install`) inside shared Conda environment  
  - Verify cron job scheduling  
  - Run final end-to-end test with small PDB example  

---

## Next Steps / Final Sprint

- Install and configure **pdb2pqr 2.1.1** from source  
- Install and verify **Dowser** with bug fix and atomdict.db  
- Compile `put_ion` and configure `arm_config.yaml` and `a_arm_paths.py`  
- Install pyARM into shared Conda environment  
- Configure module files for HPC usage  
- Run final **end-to-end test** on a small sample PDB  
- Ensure cron scheduler works for automated runs  

---

## Quick Usage Instructions (After Final Deployment)

1. Load module and activate environment:

```bash
module use /projects/earm/modules
module load pyARM-2021
# Or manually:
source /projects/earm/local/miniconda3/conda/bin/activate /projects/earm/envs/pyarm2021
export PATH=/projects/earm/software/gromacs-4.5.7/installation/bin:$PATH

2. Run pyARM on an input PDB:
cd /projects/earm/users/<your_user>
python /projects/earm/software/a-arm_fluorescence_search/scripts/run_a_arm.py \
      --input myprotein.pdb \
      --config /projects/earm/software/a-arm_fluorescence_search/arm_config.yaml
Cron will automate execution if configured.
