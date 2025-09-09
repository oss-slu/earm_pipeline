# HPC-Enabled eARM Pipeline for High-Throughput Photoreceptor Mutant Discovery

This project sets up the **a-ARM / pyARM pipeline**, a computational framework for high-throughput screening of rhodopsin-like photoreceptor mutants with altered fluorescent and spectral properties.  

## Purpose
The pipeline integrates molecular modeling, structural analysis, and quantum-mechanical/molecular-mechanical (QM/MM) methods to accelerate discovery of engineered photopigments. It automates workflows that would otherwise be slow and labor-intensive in the lab.

---

## Requirements
- Python 3.9 via Miniconda (or Anaconda)
- VMD
- Orient
- GROMACS 4.5.5 or 4.5.7
- pdb2pqr 2.1.1 (from provided source, not pip/conda)
- Dowser (source code provided by project team)
- Molcas (external license/software)
- Modules system (to manage environment variables in HPC clusters)

---

## Installation Summary

### Step 1: Python Environment
- Create a conda environment (`pyarm2021`)  
- Install Python packages:
  - pip: `numpy`, `propka`, `python-crontab`, `texttable`  
  - conda: `fpocket`, `mdanalysis`, `openbabel`, `GromacsWrapper`, `modeller`  
- Configure Modeller with license key  
- Configure `GromacsWrapper` once GROMACS is installed  

### Step 2: VMD and Orient
- Install VMD (GUI + CLI)  
- Install Orient (tarball provided separately)

### Step 3: GROMACS 4.5.7
- Build from source using GCC  
- Add binaries to PATH  
- Test installation with `mdrun`, `grompp`, etc.

### Step 4: pdb2pqr 2.1.1
- Install from provided tarball (not pip)  
- Add binary to PATH  

### Step 5: Dowser (waiting for source code)  
- Requires manual fix (bug at line 225) and compiler setup  
- Needs atomdict.db replacement  

### Step 6: pyARM
- Clone repo from GitLab  
- Compile `put_ion` (Fortran)  
- Configure `arm_config.yaml` with correct paths for VMD, pdb2pqr, Modeller, fpocket, Dowser, Molcas, GROMACS  
- Configure module files (`pyARM-2021`, `gromacs`, `miniconda`, `molcas`)  
- Modify hard-coded settings for cluster name (`my_machine`)  
- Install pyARM (`python setup.py install`)  
- Verify cron job scheduling

---

## Client
- Dr. Maureen Donlin  
- Dr. Ajith Karunarathne  

---

## Developers
- Vani Walvekar (Team Lead)   
- Ralph Tan (Developer)  
- Atiqullah Asghari (Developer)  

---

## Current Status
✅ Miniconda and Python environment installed  
✅ Core Python packages installed  
✅ VMD installed  
✅ GROMACS 4.5.7 installed  
✅ pdb2pqr 2.1.1 installed  
⏳ Waiting for Dowser source code and module templates  

---

## Next Steps
- Obtain Dowser code and module templates from client  
- Configure `arm_config.yaml` and module files  
- Install pyARM and run test workflows  
