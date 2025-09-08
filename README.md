# HPC-Enabled eARM Pipeline for High-Throughput Photoreceptor Mutant Discovery

## 📌 Project Overview
This project sets up and adapts the **a-ARM / pyARM pipeline** for **high-throughput screening of rhodopsin-like photoreceptor mutants**.  
The pipeline integrates molecular modeling, structural analysis, and QM/MM simulations to predict mutations that alter spectral properties of photopigments.

Our goal is to **deploy this workflow on HPC systems**, enabling automated, reproducible, and scalable discovery of fluorescent protein mutants.

---

## 🚀 Current Status
✅ Installed Python environment (Miniconda, Python 3.9)  
✅ Installed required Python packages (`numpy`, `propka`, `python-crontab`, `texttable`)  
✅ Installed core tools: **VMD, GROMACS 4.5.7, and pdb2pqr 2.1.1**  
⏳ Waiting on **Dowser source code and module templates** from collaborators  
🔜 Next steps: Configure `arm_config.yaml` and enable HPC cluster execution  

---

## 🧩 Installation Progress (MacOS)
1. **Miniconda + Python Environment**  
   - Created `pyarm2021` conda environment  
   - Installed scientific packages and dependencies  

2. **Core Tools Installed**  
   - VMD (for protein visualization)  
   - GROMACS 4.5.7 (for molecular dynamics)  
   - pdb2pqr 2.1.1 (for electrostatics preprocessing)  

3. **Pending Tools**  
   - Orient (optional, not yet installed)  
   - Dowser (awaiting source code from collaborators)  

---

## 🎯 Roadmap
- **Sprint 1 (Sep 8 – Sep 21):** Complete installation & testing of pyARM environment  
- **Sprint 2–4:** Configure HPC cluster integration, test small-scale protein mutants  
- **Sprint 5–6:** High-throughput screening runs, validate results against literature  

---

## 👩‍💻 Team
- **Lead:** Vani Walvekar  
- **Collaborators:** Maureen Donlin, Ajith Karunarathne  
- **Developers:** Ralph Tan, Atiqullah Asghari  

---

## 📬 Contact
For questions or collaboration:  
**Vani Walvekar** – vani.walvekar@slu.edu  
